from util.hls_exporter import export_weights

from walker_model.create_load_float_model import load_walker
import tensorflow as tf
import numpy as np


model_name = "walker_relu_tanh"
path = f"./data/model_export/{model_name}_config.h"

model, data = load_walker(model_name, do_evaluation=False)

model_params = {}
input_shape = {}
# extract weights
for layer in model.layers:
    name = layer.name
    layer_params = {}

    if isinstance(layer, tf.keras.layers.InputLayer):
        layer_params[f"inputlayer_size"] = layer.input_shape[0][2]
        input_shape[name] = layer.input_shape[0][2]

    elif isinstance(layer, tf.keras.layers.RNN):
        params = layer.get_weights()

        ff1_weights, ff1_biases, ff2_weights, ff2_biases, ta_weights, ta_biases, tb_weights, tb_biases = params[-8:]

        ltc_units = layer.cell.units
        layer_params[f"units"] = ltc_units
        layer_params["states"] = np.zeros((ltc_units, ), dtype=np.float32)

        for i in range(0, len(params[:-8]), 2):
            weights = params[i]
            weights = weights.T
            biases = params[i + 1]
            units = len(biases)
            inFeatures = weights.shape[1]

            layer_params[f"Backbone_{i}_units"] = units
            if i == 0:
                layer_params[f"Backbone_{i}_signalweights"] = weights[:, :input_shape["signal"]]
                layer_params[f"Backbone_{i}_stateweights"] = weights[:, -ltc_units:]
                layer_params[f"Backbone_{i}_signalbiases"] = np.zeros_like(biases)
                layer_params[f"Backbone_{i}_statebiases"] = biases
            else:
                layer_params[f"Backbone_{i}_inFeatures"] = inFeatures
                layer_params[f"Backbone_{i}_weights"] = weights
                layer_params[f"Backbone_{i}_biases"] = biases

        ff1_weights = ff1_weights.T
        units = len(ff1_biases)
        inFeatures = ff1_weights.shape[1]
        layer_params["ff1_units"] = units
        layer_params["ff1_inFeatures"] = inFeatures
        layer_params["ff1_weights"] = ff1_weights
        layer_params["ff1_biases"] = ff1_biases

        ff2_weights = ff2_weights.T
        units = len(ff2_biases)
        inFeatures = ff2_weights.shape[1]
        layer_params["ff2_units"] = units
        layer_params["ff2_inFeatures"] = inFeatures
        layer_params["ff2_weights"] = ff2_weights
        layer_params["ff2_biases"] = ff2_biases

        ta_weights = ta_weights.T
        units = len(ta_biases)
        inFeatures = ta_weights.shape[1]
        layer_params["ta_units"] = units
        layer_params["ta_inFeatures"] = inFeatures
        layer_params["ta_weights"] = ta_weights
        layer_params["ta_biases"] = ta_biases

        tb_weights = tb_weights.T
        units = len(tb_biases)
        inFeatures = tb_weights.shape[1]
        layer_params["tb_units"] = units
        layer_params["tb_inFeatures"] = inFeatures
        layer_params["tb_weights"] = tb_weights
        layer_params["tb_biases"] = tb_biases

    elif isinstance(layer, tf.keras.layers.Dense):
        weights, biases = layer.get_weights()

        weights = weights.T
        units = len(biases)
        inFeatures = weights.shape[1]
        layer_params["units"] = units
        layer_params["inFeatures"] = inFeatures
        layer_params["weights"] = weights
        layer_params["biases"] = biases

    model_params[name] = layer_params

export_weights(model_params, path, None)
print(f"exported model to {path}")
