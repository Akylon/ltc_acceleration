from load_model import load_walker
import tensorflow as tf
import numpy as np

from tf_nndct.optimization import IterativePruningRunner

model, data = load_walker()



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
model.compile(
        optimizer= optimizer, 
        loss=tf.keras.losses.MeanSquaredError())


def evaluate(model):
    score = model.evaluate(x=(data.test_x, data.test_times),
                           y=data.test_y,
                           verbose=2)
    return score

input_shape = [28, 28, 1]
input_spec = tf.TensorSpec((1, *input_shape), tf.float32)
runner = IterativePruningRunner(model, input_spec)

# analyze network
runner.ana(evaluate)

# prune network
# The ratio indicates the reduction of flops in the forward pass. (1-ratio)*flops_of_base_model 
sparse_model = runner.prune(ratio=0.2)

# train after pruning
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
             tf.keras.callbacks.ModelCheckpoint('./data/walker_checkpoint/model_pruned.h5',
             save_best_only=True,
             mode='min', monitor='loss')
            ]

hist = sparse_model.fit(
        x=(data.train_x, data.train_times),
        y=data.train_y,
        batch_size=config["batch_size"],
        epochs=config["epochs"],
        validation_data=((data.valid_x, data.valid_times), data.valid_y),
        callbacks=callbacks,
        verbose=True,
    )

print(evaluate(sparse_model))