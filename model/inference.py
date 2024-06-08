from walker_model.create_load_float_model import load_walker, load_training_data, load_quant_walker
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

data = load_training_data()

model_name = "walker_relu_tanh"

model, data = load_quant_walker(model_name, False)
model.run_eagerly = True


x = np.arange(17*64).reshape((1, 64, 17))*100
t = np.arange(64).reshape((1, 64, 1))

x_inference = (data.test_x, data.test_times)
#x_inference = (x, t)

for layer in model.layers:
    if isinstance(layer, tf.keras.layers.RNN):
        print("cleared stats of LTC layer")
        layer.cell.clear_stats()

y = model.predict(x=x_inference)

for layer in model.layers:
    if isinstance(layer, tf.keras.layers.RNN):
        weights = layer.get_weights()
        cell = layer.cell
        stats = cell.stats
        ff1 = stats["ff1"]
        dense = ff1["dense"]

        # extract weights
        quant_weights = cell.get_quant_weights(bit_width=8, path=f'./data/{model_name}_checkpoint/cfc_weights')

y_test = data.test_y

diff = y[:, 0, 0]-y_test[:, 0, 0]
print(diff.mean())
print(diff.max())
print(diff.min())


do_print = False
if do_print:
    plt.figure()
    plt.plot(diff, label="diff")
    plt.figure()
    plt.plot(y_test[:, 0, 0], label="test")
    plt.plot(y[:, 0, 0], label="pred")
    plt.legend()
    plt.show()

print("finished")