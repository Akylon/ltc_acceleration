import tensorflow as tf
import numpy as np
from .configs import config_walker, data_config
from .irregular_sampled_datasets import Walker2dImitationData

seq_len = data_config["seq_len"]

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

def train_walker(model, model_name):
    print("\n\nCalled train_walker()")
    data = load_training_data()

    callbacks = [BackupCallback(model),
                tf.keras.callbacks.ModelCheckpoint(f'./data/{model_name}_checkpoint/{model_name}.h5',
                    save_best_only=True,
                    mode='min', monitor='loss')
                ]

    config = config_walker

    # Fit model
    print("start training")
    hist = model.fit(
        x=(data.train_x, data.train_times),
        y=data.train_y,
        batch_size=config["batch_size"],
        epochs=config["epochs"],
        validation_data=((data.valid_x, data.valid_times), data.valid_y),
        callbacks=callbacks,
        verbose=True,
    )

    # Evaluate trained model
    print("evaluate trained model")
    test_loss = model.evaluate(
        x=(data.test_x, data.test_times), y=data.test_y, verbose=2
    )
    print(f"trained model loss: {test_loss}")

    print("Executed train_walker() succesfully\n\n")

    return model


def load_training_data():
    print("load data for validation")
    data = Walker2dImitationData(seq_len=seq_len)
    return data