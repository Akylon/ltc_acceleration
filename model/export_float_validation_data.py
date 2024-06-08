from walker_model.create_load_float_model import load_walker, load_training_data, load_quant_walker
import numpy as np
import matplotlib.pyplot as plt
import os
import tensorflow as tf
def get_validation_data(inputs, layer):
    result = {}
    # extract float weights
    layer_name = layer.name
    if isinstance(layer, tf.keras.layers.Dense):
        outputs = layer(inputs)
        ins = inputs.numpy()
        outs = outputs.numpy()
        result[f"{layer.name}"] = {"in": ins, "noActivation_out": outs}
    if isinstance(layer, tf.keras.layers.Activation):
        outputs = layer(inputs)
        ins = inputs.numpy()
        outs = outputs.numpy()
        result[f"{layer.name}"] = {"in": ins, "activation_out": outs}
    return result


data = load_training_data()

model_name = "walker_relu_tanh"
path = "./data/walker_relu_tanh_checkpoint/float_validation/"

model, data = load_walker(model_name, True)
model.run_eagerly = True


layers = model.layers
t_in_layer = layers[0]
sig_in_layer = layers[1]
layers = layers[2:]

sig_out = sig_in_layer(data.test_x)
t_out = t_in_layer(data.test_times.astype(dtype=np.float32))

input = (sig_out, t_out)

n_samples = t_out.shape[0]
# store output of each layer
for layer in layers:
    output = layer(input)  # output.shape = (samples, sequence_len, states_after_update)
    filename = layer.name

    directory = path + filename
    dir_exists = os.path.exists(directory)

    if not dir_exists:
        os.makedirs(directory)

    if isinstance(input, list) or isinstance(input, tuple):
        sig_in = input[0]
        t_in = input[1]

        eval_data = layer.cell.get_validation_data([sig_in, t_in], output)
        for layer_name, values in eval_data.items():
            for type, value in values.items():
                np.save(directory + f"/whitebox/{layer_name}_{type}", value)

        for i in range(n_samples):
            if i == 0:
                np.savetxt(directory + f"/blackbox/{filename}_test_sig_input_{i}.txt", sig_in[i].numpy())
                np.savetxt(directory + f"/blackbox/{filename}_test_t_input_{i}.txt", t_in[i].numpy())
            np.savetxt(directory + f"/blackbox/{filename}_sig_input_{i}.txt", sig_in[i].numpy())
            np.savetxt(directory + f"/blackbox/{filename}_t_input_{i}.txt", t_in[i].numpy())
            np.savetxt(directory + f"/blackbox/{filename}_output_{i}.txt", output[i].numpy())
    else:
        eval_data = get_validation_data(input, layer)
        for layer_name, values in eval_data.items():
            for type, value in values.items():
                layer_name = "".join(layer_name.split(sep="_"))
                np.save(directory + f"/whitebox/{layer_name}_{type}", value)
        for i in range(n_samples):
            np.savetxt(directory + f"/blackbox/{filename}_input_{i}.txt", input[i].numpy())
            np.savetxt(directory + f"/blackbox/{filename}_output_{i}.txt", output[i].numpy())

    input = output





x_inference = (data.test_x, data.test_times)


y = model.predict(
    x=x_inference
)

y_test = data.test_y

fig, axs = plt.subplots(3, 6)
for i in range(17):
    row = i % 3
    col = i//3
    y_t = y_test[0, :, i]
    y_i = y[0, :, i]
    axs[row, col].plot(y_t, label="test")
    axs[row, col].plot(y_i, label="pred")
plt.legend()
plt.show()

print("finished")


