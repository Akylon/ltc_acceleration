'''
This script loads the 2D ltc walker model and quantises it with post training quantisation (PTQ).
'''

from walker_model.irregular_sampled_datasets import Walker2dImitationData
from walker_model.create_load_float_model import load_walker
import tensorflow as tf
import numpy as np

from walker_model.tf_cfc import CfcCell, MixedCfcCell, LTCCell

import logging
# ignore cudart warnings and information
tf.get_logger().setLevel(logging.ERROR)

try:
    from tensorflow_model_optimization.quantization.keras import vitis_quantize
except:
    raise ImportError(
        "Vitis-AI can only be imported from docker container. Run this script from vitis-ai docker container")


model_name = "walker_relu_tanh"

model, data = load_walker(model_name)

for layer in model.layers:
    if isinstance(layer, tf.keras.layers.Dense):
        W, B = layer.get_weights()
        get_scale = lambda abs_max_w, bit_width : (2**(bit_width-1)-1)/abs_max_w
        print(f"max_w: {np.abs(W).max()}")
        print(f"max_b: {np.abs(B).max()}")
        print(f"s_w: {get_scale(np.abs(W).max(), 8)}")
        print(f"s_b: {get_scale(np.abs(B).max(), 8)}")
        s_w = 2**np.ceil(np.log2(get_scale(np.abs(W).max(), 8)))
        s_b = 2**np.ceil(np.log2(get_scale(np.abs(B).max(), 8)))
        print(f"s_w_2: {s_w}")
        print(f"s_b_2: {s_b}")
        print(f"B: {B}")
        print(f"B_scaled: {np.ndarray.astype(B*s_b, int)}")
        print(f"B_scaled_s_w: {np.ndarray.astype(B*s_w, int)}")

tf.keras.utils.plot_model(
    model,
    to_file=f"./data/{model_name}_checkpoint/inside_float.png",
    show_shapes=True,
    show_layer_activations=True,
    show_layer_names=True
)

quantizer = vitis_quantize.VitisQuantizer(
    model,
    #custom_quantize_strategy=None,
    custom_objects={'CfcCell': CfcCell})

# include_fast_ft=True turns on fast finetuning, which increases accuracy with the cost of longer qunatisation times.
model = quantizer.quantize_model(calib_dataset=(data.valid_x, data.valid_times),
                                 calib_steps=None,
                                 calib_batch_size=256,
                                 weight_bit=8,
                                 input_bit=8,
                                 bias_bit=8,
                                 activation_bit=8,
                                 include_fast_ft=True)

model.save(f'./data/{model_name}_checkpoint/model_PTQ.h5')
model.summary()

tf.keras.utils.plot_model(
    model,
    to_file=f"./data/{model_name}_checkpoint/inside_PTQ.png",
    show_shapes=True,
    show_layer_activations=True,
    show_layer_names=True
)

print("Dump model results for inference validation")
dataset = (data.valid_x, data.valid_times)
vitis_quantize.VitisQuantizer.dump_model(model,
                                        dataset=dataset,
                                        output_dir=f"./data/{model_name}_checkpoint/dump_PTQ",
                                        dump_float=False,
                                        weights_only=False)


# Evaluate quantised model
print("evaluate quantised model")
model.compile(
    loss=tf.keras.losses.MeanSquaredError(),
)
test_loss = model.evaluate(
    x=(data.test_x, data.test_times), y=data.test_y, verbose=2
)
print(f"quantised model loss: {test_loss}")