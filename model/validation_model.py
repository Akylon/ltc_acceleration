import numpy as np
import tensorflow as tf
from walker_model.cfc_quant import CfcCellQuant


def dump_intermediate_results(model, signal, time, dir_path: str):
    signal = signal.astype(dtype=float)
    time = time.astype(dtype=float)

    signal_in_layer, time_in_layer, ltc_layer = model.layers

    # prepare input
    t = time_in_layer(time)
    x = signal_in_layer(signal)
    input = (x, t)

    # ltc layer
    path = dir_path + f"/{ltc_layer.name}"
    output = ltc_layer(input)
    dump_numpy_samples(t.numpy(), path + "_input_t")
    dump_numpy_samples(x.numpy(), path + "_input_x")
    dump_numpy_samples(output.numpy(), path + "_output")



def dump_numpy_samples(np_3d_array, filename_base):
    for i in range(np_3d_array.shape[0]):
        np.savetxt(filename_base + f"_{i:03}", np_3d_array[i])

validation_config = {
    "backbone_units": 4,
    "size": 2,
    "store_intermedieate_results" : True,

    "clipnorm": 1,
    "optimizer": "adam",
    "epochs": 50,
    "base_lr": 0.02,
    "decay_lr": 0.95,
    "backbone_activation": "relu",
    "backbone_dr": 0.1,
    "forget_bias": 1.6,
    "backbone_layers": 1,
    "weight_decay": 1e-06,
    "use_mixed": False,
}

seq_len = 4
input_size = 3
number_of_samples = 2

# generate some simple arbitrary inputs
x = np.arange(input_size*seq_len*number_of_samples).reshape((number_of_samples, seq_len, input_size))
x = (x-input_size*seq_len//2)
t = np.arange(seq_len*number_of_samples).reshape((number_of_samples, seq_len, 1))
inputs = (x, t)

# create simple validation model
signal_input = tf.keras.Input(shape=(seq_len, input_size), name="robot")
time_input = tf.keras.Input(shape=(seq_len, 1), name="time")

cell = CfcCellQuant(units=validation_config["size"], hparams=validation_config)
rnn = tf.keras.layers.RNN(cell, time_major=False, return_sequences=True, name="ltc")

output_states = rnn((signal_input, time_input))

model = tf.keras.Model(inputs=[signal_input, time_input], outputs=[output_states])

model.compile()
model.run_eagerly = True
model.summary()

# set weights to specific quantised values
for layer in model.layers:
    if isinstance(layer, tf.keras.layers.RNN):
        cell = layer.cell
        backbone_w = np.arange(validation_config["size"])
        ff1_w = np.arange(validation_config["size"]*validation_config["size"])

# call model
outputs = model.predict(inputs, batch_size=1)

print(outputs)

dump_intermediate_results(model, x, t, "./data/validation")


