import tensorflow as tf
import numpy as np


def add_cfc_quant(signal_input, time_input, units, hparams):
    cell = CfcCellQuant(units=units, hparams=hparams)

    rnn = tf.keras.layers.RNN(cell, time_major=False, return_sequences=True, name="ltc")
    rnn([signal_input, time_input, ])


class CfcCellQuant(tf.keras.layers.Layer):
    def __init__(self, units, hparams, **kwargs):
        super(CfcCellQuant, self).__init__(**kwargs)
        self.units = units
        self.state_size = units
        self.hparams = hparams
        self._no_gate = False
        self.clear_stats()
        
    def update_stat(self, stat_key, input, output):
        if self.hparams["store_intermedieate_results"]:
            stat_dict = self.stats[stat_key]
            stat_dict["input"].append(input)
            stat_dict["output"].append(output)

    def update_input(self, inputs, states):
         if self.hparams["store_intermedieate_results"]:
            stat_dict = self.stats["inputs"]
            stat_dict["input"].append(inputs)
            stat_dict["state"].append(states)

    def clear_stats(self):
        self.stats = {}

        self.stats["inputs"] = {"input":[], "state": []}
        self.stats["backbone"] = {"input": [], "output": []}
        self.stats["ff1"] = {"input": [], "output": []}
        self.stats["ff1_activation"] = {"input": [], "output": []}
        self.stats["ff2"] = {"input": [], "output": []}
        self.stats["ff2_activation"] = {"input": [], "output": []}
        self.stats["time_a"] = {"input": [], "output": []}
        self.stats["time_b"] = {"input": [], "output": []}

        

    def build(self, input_shape):
        if isinstance(input_shape[0], tuple):
            # Nested tuple
            input_dim = input_shape[0][-1]
        else:
            input_dim = input_shape[-1]

        if self.hparams.get("backbone_activation") == "relu":
            backbone_activation = tf.nn.relu
        elif self.hparams.get("backbone_activation") == "tanh":
            backbone_activation = tf.nn.tanh
        else:
            raise ValueError("Unknown backbone activation")

        self._no_gate = False
        if "no_gate" in self.hparams:
            self._no_gate = self.hparams["no_gate"]
        self._minimal = False
        if "minimal" in self.hparams:
            self._minimal = self.hparams["minimal"]

        self.backbone = []
        for i in range(self.hparams["backbone_layers"]):

            self.backbone.append(
                tf.keras.layers.Dense(
                    self.hparams["backbone_units"],
                    backbone_activation,
                    kernel_regularizer=tf.keras.regularizers.L2(
                        self.hparams["weight_decay"]
                    ),
                    name=f"Dense_Backbone_{i}"
                )
            )
            self.backbone.append(tf.keras.layers.Dropout(self.hparams["backbone_dr"]))

        self.backbone = tf.keras.models.Sequential(self.backbone)

        if self._minimal:
            self.ff1 = tf.keras.layers.Dense(
                self.units,
                kernel_regularizer=tf.keras.regularizers.L2(
                    self.hparams["weight_decay"]
                ),
            )
            self.w_tau = self.add_weight(
                shape=(1, self.units), initializer=tf.keras.initializers.Zeros()
            )
            self.A = self.add_weight(
                shape=(1, self.units), initializer=tf.keras.initializers.Ones()
            )
        else:
            self.ff1 = tf.keras.layers.Dense(
                self.units,
                activation=None,  #tf.tanh, # activation='relu',  # use tanh instead of lecun_tanh
                kernel_regularizer=tf.keras.regularizers.L2(
                    self.hparams["weight_decay"]
                ),
                name="ff1"
            )
            self.ff1_activation = tf.keras.layers.Activation("tanh", name="ff1_activation")

            self.ff2 = tf.keras.layers.Dense(
                self.units,
                activation=None, #tf.tanh, activation='relu', use tanh instead of lecun_tanh
                kernel_regularizer=tf.keras.regularizers.L2(
                    self.hparams["weight_decay"]
                ),
                name="ff2"
            )
            self.ff2_activation = tf.keras.layers.Activation("tanh", name="ff2_activation")
            
            self.time_a = tf.keras.layers.Dense(
                self.units,
                kernel_regularizer=tf.keras.regularizers.L2(
                    self.hparams["weight_decay"]
                ),
                name="ta"
            )
            self.time_b = tf.keras.layers.Dense(
                self.units,
                kernel_regularizer=tf.keras.regularizers.L2(
                    self.hparams["weight_decay"]
                ),
                name="tb"
            )
        self.built = True

    def call(self, inputs, states, **kwargs):
        hidden_state = states[0]
        t = 1.0
        if (isinstance(inputs, tuple) or isinstance(inputs, list)) and len(inputs) > 1:
            elapsed = inputs[1]
            t = tf.reshape(elapsed, [-1, 1])
            inputs = inputs[0]

        x_backbone = tf.keras.layers.Concatenate()([inputs, hidden_state])

        # store inputs
        #self.update_input(inputs, hidden_state)

        # backbone call
        x = self.backbone(x_backbone)
        #self.update_stat("backbone", x_backbone, x)

        # ff1 call
        ff1_dense_out = self.ff1(x)
        ff1 = self.ff1_activation(ff1_dense_out)
        #self.update_stat("ff1", x, ff1_dense_out)
        #self.update_stat("ff1_activation", ff1_dense_out, ff1)
        
        # Cfc
        ff2_dense_out = self.ff2(x)
        ff2 = self.ff2_activation(ff2_dense_out)
        #self.update_stat("ff2", x, ff2_dense_out)
        #self.update_stat("ff2_activation", ff2_dense_out, ff2)
        
        t_a = self.time_a(x)
        #self.update_stat("time_a", x, t_a)

        t_b = self.time_b(x)
        #self.update_stat("time_b", x, t_b)

        
        t_interp = tf.nn.sigmoid(-t_a * t + t_b)

        new_hidden = ff1 * (1.0 - t_interp) + t_interp * ff2

        return new_hidden, [new_hidden]
    
    def get_quant_weights(self, bit_width, path=None):
        # function to calculate scale for transformation: new_W = scale*W
        get_scale = lambda abs_max_w, bit_width : (2**(bit_width-1)-1)/abs_max_w

        quant_weights = {}
        # quantise shared backbone
        i = 0
        for layer in self.backbone.layers:
            # extract float weights
            if isinstance(layer, tf.keras.layers.Dense):
                W, B = layer.get_weights()
                if i==0:
                    W_sig = W[:-self.units, :]
                    W_state = W[-self.units:, :]

                    # calculate scale factors
                    s_wSig = get_scale(np.abs(W_sig).max(), bit_width)
                    s_wSig = np.floor(np.log2(s_wSig))  # use next higher power of 2

                    s_wState = get_scale(np.abs(W_state).max(), bit_width)
                    s_wState = np.floor(np.log2(s_wState))

                    s_b = get_scale(np.abs(B).max(), bit_width)
                    s_b = np.floor(np.log2(s_b))  # use next higher power of 2

                    # quantise weights
                    W_sig_quant = np.ndarray.astype(np.round(W_sig * 2 ** float(s_wSig)), int)
                    W_state_quant = np.ndarray.astype(np.round(W_state * 2 ** float(s_wState)), int)
                    B_quant = np.ndarray.astype(np.round(B * 2 ** float(s_b)), int)

                    boundary = 2 ** (bit_width - 1) - 1
                    # check if within range of quantisation
                    if W_sig_quant.max() > boundary or W_sig_quant.min() < -boundary or W_state_quant.max() > boundary or W_state_quant.min() < -boundary or B_quant.max() > boundary or B_quant.min() < -boundary:
                        raise (ValueError("quantisation failed, because weights not within range after quantisation!"))

                    quant_weights[f"{layer.name}_sig"] = [W_sig_quant, -s_wSig, np.zeros_like(B), -s_b]
                    quant_weights[f"{layer.name}_state"] = [W_state_quant, -s_wState, B_quant, -s_b]
                    i += 1
                else:
                    # calculate scale factors
                    s_w = get_scale(np.abs(W).max(), bit_width)
                    s_w = np.floor(np.log2(s_w)) # use next higher power of 2

                    s_b = get_scale(np.abs(B).max(), bit_width)
                    s_b = np.floor(np.log2(s_b)) # use next higher power of 2

                    # quantise weights
                    W_quant = np.ndarray.astype(np.round(W*2**float(s_w)), int)
                    B_quant = np.ndarray.astype(np.round(B*2**float(s_b)), int)

                    boundary = 2**(bit_width-1)-1
                    # check if within range of quantisation
                    if W_quant.max() > boundary or W_quant.min() < -boundary or B_quant.max() > boundary or B_quant.min() < -boundary:
                        raise(ValueError("quantisation failed, because weights not within range after quantisation!"))

                    quant_weights[f"backbone_{i}"] = [W_quant, -s_w, B_quant, -s_b]
                i+=1

        # quantise dense layers
        layers = ((self.ff1, self.ff1.name), (self.ff2, self.ff2.name), (self.time_a, self.time_a.name), (self.time_b, self.time_b.name))
        for layer, layer_name in layers:
            # extract float weights
            W, B = layer.get_weights()

            # calculate scale factors
            s_w = get_scale(np.abs(W).max(), bit_width)
            s_w = int(np.floor(np.log2(s_w)))  # use next higher power of 2

            s_b = get_scale(np.abs(B).max(), bit_width)
            s_b = int(np.floor(np.log2(s_b)))  # use next higher power of 2

            # quantise weights
            W_quant = np.ndarray.astype(np.round(W*2**float(s_w)), int)
            B_quant = np.ndarray.astype(np.round(B*2**float(s_b)), int)

            boundary = 2 ** (bit_width - 1) - 1
            # check if within range of quantisation
            if W_quant.max() > boundary or W_quant.min() < -boundary or B_quant.max() > boundary or B_quant.min() < -boundary:
                raise (ValueError("quantisation failed, because weights not within range after quantisation!"))

            quant_weights[layer_name] = [W_quant, -s_w, B_quant, -s_b]

        # save weights to text file
        if path is not None:
            for key, items in quant_weights.items():
                np.savetxt(path+f"/{key}_W", items[0], fmt="%d")
                np.savetxt(path+f"/{key}_sw", -np.array([items[1]]), fmt="%d")
                np.savetxt(path+f"/{key}_B", items[2], fmt="%d")
                np.savetxt(path+f"/{key}_sb", -np.array([items[3]]), fmt="%d")

        return quant_weights

        def get_validation_data(self, inputs, states_out):
            result = {}
            t = inputs[1]
            sig = inputs[0]

            # since states_out is the output hidden state, it is one iteration ahead, which must be corrected.
            init_state = tf.zeros((states_out.shape[0], 1, states_out.shape[2]))
            states = tf.concat([init_state, states_out[:, :-1, :]], 1)
            x = tf.keras.layers.Concatenate()([sig, states])

            for layer in self.backbone.layers:
                # extract float weights
                if isinstance(layer, tf.keras.layers.Dense):
                    outputs = layer(x)
                    backbone_ins = x.numpy()
                    backbone_outs = outputs.numpy()
                    x = outputs
                    result[f"backbone_{layer.name}"] = {"in": backbone_ins, "out": backbone_outs}
                if isinstance(layer, tf.keras.layers.Activation):
                    outputs = layer(x)
                    backbone_ins = x.numpy()
                    backbone_outs = outputs.numpy()
                    x = outputs
                    result[f"backbone_{layer.name}"] = {"in": backbone_ins, "out": backbone_outs}

            ff1_out = self.ff1(x)
            ff1_activation_out = self.ff1_activation(ff1_out)
            ff2_out = self.ff2(x)
            ff2_activation_out = self.ff2_activation(ff2_out)
            t_a_out = self.time_a(x)
            t_b_out = self.time_b(x)

            result[f"ff1"] = {"in": x.numpy(), "out_noActivation": ff1_out.numpy(),
                              "out_activation": ff1_activation_out}
            result[f"ff2"] = {"in": x.numpy(), "out_noActivation": ff2_out.numpy(),
                              "out_activation": ff2_activation_out}
            result[f"ta"] = {"in": x.numpy(), "out_noActivation": t_a_out.numpy()}
            result[f"tb"] = {"in": x.numpy(), "out_noActivation": t_b_out.numpy()}

            t_interp = tf.nn.sigmoid(-t_a_out * t + t_b_out)
            new_hidden = ff1_activation_out * (1.0 - t_interp) + t_interp * ff2_activation_out
            result[f"new_states"] = {"out": new_hidden.numpy()}

            return result
        
