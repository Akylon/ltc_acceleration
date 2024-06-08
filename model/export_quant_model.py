from util.hls_exporter import export_weights

from walker_model.create_load_float_model import load_quant_walker
import tensorflow as tf
import numpy as np


model_name = "walker_relu_tanh"
path = f"./data/model_quant_export/{model_name}_quant_config.h"
statsPathLtc = f"./data/model_quant_export/{model_name}_ltc_statistics.txt"
statsPathDense = f"./data/model_quant_export/{model_name}_dense_out_statistics.txt"
model_resolution = 8

get_scale = lambda abs_max_w, bit_width : (2**(bit_width-1)-1)/abs_max_w

# load stats of ltc layer
stats_dict_ltc = {}
with open(statsPathLtc, "r") as fp:
    lines = fp.readlines()
    for line in lines:
        tokens = line.strip().split(sep=" ")
        name = tokens[0]
        tokens = tokens[1:]
        i = 0
        stats = {}
        while i < len(tokens):
            stats[tokens[i]] = (float(tokens[i+1]), float(tokens[i+2]))
            i += 3
        stats_dict_ltc[name] = stats

# load stats of dense layer
stats_dict_dense = {}
with open(statsPathDense, "r") as fp:
    lines = fp.readlines()
    for line in lines:
        tokens = line.strip().split(sep=" ")
        name = tokens[0]
        tokens = tokens[1:]
        i = 0
        stats = {}
        while i < len(tokens):
            stats[tokens[i]] = (float(tokens[i + 1]), float(tokens[i + 2]))
            i += 3
        stats_dict_dense[name] = stats

# load model
model, data = load_quant_walker(model_name, do_evaluation=False)


# quantise model
model_params = {}
input_shape = {}
# extract weights
for layer in model.layers:
    name = layer.name
    layer_params = {}

    # extract data from input layer since input is split into two vectors
    if isinstance(layer, tf.keras.layers.InputLayer):
        layer_params[f"inputlayer_size"] = layer.input_shape[0][2]
        input_shape[name] = layer.input_shape[0][2]

    # extract parameter of ltc
    elif isinstance(layer, tf.keras.layers.RNN):

        params = layer.cell.get_quant_weights(bit_width=model_resolution)

        ltc_units = layer.cell.units
        layer_params[f"units"] = ltc_units
        layer_params["states"] = np.zeros((ltc_units, ), dtype=int)

        first_iteration = True
        for sub_layer_name, sub_layer_params in params.items():
            # stats export
            if "Backbone" in sub_layer_name:
                stat_key = "_".join(sub_layer_name.split(sep="_")[:-1])
            else:
                stat_key = sub_layer_name
            stats = stats_dict_ltc[stat_key]

            if "out_noActivation" in stats.keys():
                scale = get_scale(np.abs(np.array(stats["out_noActivation"])).max(), model_resolution)
                scale = int(np.floor(np.log2(scale)))
                layer_params[f"{sub_layer_name}_outNoActivationScale"] = -scale
            if "out_activation" in stats.keys():
                scale = get_scale(np.abs(np.array(stats["out_activation"])).max(), model_resolution)
                scale = int(np.floor(np.log2(scale)))
                layer_params[f"{sub_layer_name}_out_activationScale"] = -scale

            if "in_sig" in stats.keys():
                scale = get_scale(np.abs(np.array(stats["in_sig"])).max(), model_resolution)
                scale = int(np.floor(np.log2(scale)))
                layer_params[f"{sub_layer_name}_inSigScale"] = -scale
            if "in_state" in stats.keys():
                scale = get_scale(np.abs(np.array(stats["in_state"])).max(), model_resolution)
                scale = int(np.floor(np.log2(scale)))
                layer_params[f"{sub_layer_name}_inStateScale"] = -scale
            if "in" in stats.keys():
                scale = get_scale(np.abs(np.array(stats["in"])).max(), model_resolution)
                scale = int(np.floor(np.log2(scale)))
                layer_params[f"{sub_layer_name}_inScale"] = -scale

            # weight export
            W, sw, B, sb = sub_layer_params
            W = W.T
            inFeatures = W.shape[1]
            units = len(B)
            layer_params[f"{sub_layer_name}_sw"] = int(sw)
            layer_params[f"{sub_layer_name}_sb"] = int(sb)

            layer_params[f"{sub_layer_name}_units"] = units
            layer_params[f"{sub_layer_name}_inFeatures"] = inFeatures
            layer_params[f"{sub_layer_name}_weights"] = W
            layer_params[f"{sub_layer_name}_biases"] = B


    # extract parameter of dense layers
    elif isinstance(layer, tf.keras.layers.Dense):
        # quantise layer
        W, B = layer.get_weights()

        layer_name = layer.name
        W = W.T
        units = len(B)
        inFeatures = W.shape[1]

        s_w = get_scale(np.abs(W).max(), model_resolution)
        s_w = np.floor(np.log2(s_w))  # use next higher power of 2

        s_b = get_scale(np.abs(B).max(), model_resolution)
        s_b = np.floor(np.log2(s_b))  # use next higher power of 2

        # quantise weights
        W_quant = np.ndarray.astype(np.round(W * 2 ** float(s_w)), int)
        B_quant = np.ndarray.astype(np.round(B * 2 ** float(s_b)), int)
        s_w = -s_w
        s_b = -s_b

        boundary = 2 ** (model_resolution - 1) - 1
        # check if within range of quantisation
        if W_quant.max() > boundary or W_quant.min() < -boundary or B_quant.max() > boundary or B_quant.min() < -boundary:
            raise (ValueError("quantisation failed, because weights not within range after quantisation!"))

        stat_key = "".join(layer.name.split(sep="_"))
        stats = stats_dict_dense[stat_key]
        if "in" in stats.keys():
            scale = get_scale(np.abs(np.array(stats["in"])).max(), model_resolution)
            scale = int(np.floor(np.log2(scale)))
            layer_params[f"{layer.name}_inScale"] = -scale
        if "out_noActivation" in stats.keys():
            scale = get_scale(np.abs(np.array(stats["out_noActivation"])).max(), model_resolution)
            scale = int(np.floor(np.log2(scale)))
            layer_params[f"{layer.name}_outNoActivationScale"] = -scale
        if "out_activation" in stats.keys():
            scale = get_scale(np.abs(np.array(stats["out_activation"])).max(), model_resolution)
            scale = int(np.floor(np.log2(scale)))
            layer_params[f"{layer.name}_out_activationScale"] = -scale



        layer_params[f"_sw"] = int(s_w)
        layer_params[f"_sb"] = int(s_b)

        layer_params[f"_units"] = units
        layer_params[f"_inFeatures"] = inFeatures
        layer_params[f"_weights"] = W_quant
        layer_params[f"_biases"] = B_quant



    model_params[name] = layer_params

export_weights(model_params, path, model_resolution)
print(f"exported model to {path}")
