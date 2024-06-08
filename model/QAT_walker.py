'''
This script loads the 2D ltc walker model and quantises it with post training quantisation (PTQ).
'''

from load_model import load_walker
import tensorflow as tf
import numpy as np

from tf_cfc import CfcCell, MixedCfcCell, LTCCell

import logging
# ignore cudart warnings and information
tf.get_logger().setLevel(logging.ERROR)

try:
    from tensorflow_model_optimization.quantization.keras import vitis_quantize
except:
    raise ImportError(
        "Vitis-AI can only be imported from docker container. Run this script from vitis-ai docker container")


model, data = load_walker()

tf.keras.utils.plot_model(
    model,
    to_file="./data/walker_checkpoint/inside_float.png",
    show_shapes=True,
    show_layer_activations=True,
    show_layer_names=True
)


quantizer = vitis_quantize.VitisQuantizer(
    model,
    #custom_quantize_strategy=None,
    custom_objects={'CfcCell': CfcCell})


qat_model = quantizer.get_qat_model(
    init_quant=True,
    calib_dataset=(data.valid_x, data.valid_times),
    convert_sigmoid_to_hard_sigmoid=True
    )
qat_model.summary()


BEST_DEFAULT = {
    "clipnorm": 1,
    "optimizer": "adam",
    "batch_size": 256,
    "size": 64,
    "epochs": 50,
    "base_lr": 0.02,
    "decay_lr": 0.95,
    "backbone_activation": "silu",
    "backbone_dr": 0.1,
    "forget_bias": 1.6,
    "backbone_units": 256,
    "backbone_layers": 1,
    "weight_decay": 1e-06,
    "use_mixed": False,
}

config = BEST_DEFAULT

base_lr = config["base_lr"]
decay_lr = config["decay_lr"]
train_steps = data.train_x.shape[0] // config["batch_size"]

learning_rate_fn = tf.keras.optimizers.schedules.ExponentialDecay(base_lr, train_steps, decay_lr)
opt = (
    tf.keras.optimizers.Adam
    if config["optimizer"] == "adam"
    else tf.keras.optimizers.RMSprop
)
optimizer = opt(learning_rate_fn, clipnorm=config["clipnorm"])

#"decay_lr": 0.95,
qat_model.compile(
        optimizer= optimizer, 
        loss=tf.keras.losses.MeanSquaredError())

class BackupCallback(tf.keras.callbacks.Callback):
    def __init__(self, model):
        super(BackupCallback, self).__init__()
        self.saved_weights = None
        self.model = model
        self.best_loss = np.PINF

    def on_epoch_end(self, epoch, logs=None):
        if logs["val_loss"] < self.best_loss:
            self.best_loss = logs["val_loss"]
            print(f" new best -> {logs['val_loss']:0.3f}")
            self.saved_weights = self.model.get_weights()

    def restore(self):
        if self.best_loss is not None:
            self.model.set_weights(self.saved_weights)

callbacks = [BackupCallback(model),
             tf.keras.callbacks.ModelCheckpoint('./data/walker_checkpoint/model_QAT.h5',
             save_best_only=True,
             mode='min', monitor='loss')
            ]

hist = qat_model.fit(
        x=(data.train_x, data.train_times),
        y=data.train_y,
        batch_size=config["batch_size"],
        epochs=config["epochs"],
        validation_data=((data.valid_x, data.valid_times), data.valid_y),
        callbacks=callbacks,
        verbose=True,
    )


# Evaluate quantised model
print("evaluate quantised model")
model.compile(
    loss=tf.keras.losses.MeanSquaredError(),
)
test_loss = model.evaluate(
    x=(data.test_x, data.test_times), y=data.test_y, verbose=2
)
print(f"quantised model loss: {test_loss}")