import tensorflow as tf
from .tf_cfc import CfcCell, MixedCfcCell, LTCCell
from .configs import config_walker, data_config
from .train_walker import load_training_data
from .cfc_quant import CfcCellQuant

seq_len = data_config["seq_len"]
input_size = data_config["input_size"]
number_of_samples = data_config["number_of_samples"]


def create_float_model():
    print("\n\nCalled create_float_model()")
    config = config_walker

    print("initialise model")
    cell = CfcCell(units=config["size"], hparams=config)

    signal_input = tf.keras.Input(shape=(seq_len, input_size), name="signal")
    time_input = tf.keras.Input(shape=(seq_len, 1), name="time")

    rnn = tf.keras.layers.RNN(cell, time_major=False, return_sequences=True, name="ltc")

    output_states = rnn((signal_input, time_input))
    y = tf.keras.layers.Dense(input_size, name="dense_out")(output_states)

    model = tf.keras.Model(inputs=[signal_input, time_input], outputs=[y])

    print("compile model")
    base_lr = config["base_lr"]
    decay_lr = config["decay_lr"]
    train_steps = number_of_samples // config["batch_size"]
    learning_rate_fn = tf.keras.optimizers.schedules.ExponentialDecay(
        base_lr, train_steps, decay_lr
    )
    opt = (
        tf.keras.optimizers.Adam
        if config["optimizer"] == "adam"
        else tf.keras.optimizers.RMSprop
    )
    optimizer = opt(learning_rate_fn, clipnorm=config["clipnorm"])


    model.compile(
        optimizer = optimizer,
        loss=tf.keras.losses.MeanSquaredError(),
    )
    model.run_eagerly = True
    print("Executed create_float_model() successfully\n\n")

    model.summary()

    return model


def load_walker(model_name, do_evaluation=True):
    print("\n\ncalled load_walker()")

    data = load_training_data()

    model = create_float_model()

    if do_evaluation:
        # Evaluate untrained model for reference
        print("\n\nevaluate untrained model")
        test_loss = model.evaluate(
            x=(data.test_x, data.test_times), y=data.test_y, verbose=2
        )
        print(f"untrained model loss: {test_loss}")

    # Load trained model
    print("\n\nload trained model")
    model.load_weights(f'./data/{model_name}_checkpoint/{model_name}.h5')

    if do_evaluation:
        # Evaluate trained model
        print("evaluate trained model")
        test_loss = model.evaluate(
            x=(data.test_x, data.test_times), y=data.test_y, verbose=2
        )
        print(f"trained model loss: {test_loss}")

    print("Executed load_walker() successfully\n\n")
    return model, data


def create_quant_model():
    print("\n\nCalled create_float_model()")
    config = config_walker

    print("initialise model")
    cell = CfcCellQuant(units=config["size"], hparams=config)

    signal_input = tf.keras.Input(shape=(seq_len, input_size), name="signal")
    time_input = tf.keras.Input(shape=(seq_len, 1), name="time")

    rnn = tf.keras.layers.RNN(cell, time_major=False, return_sequences=True, name="ltc")

    output_states = rnn((signal_input, time_input))
    y = tf.keras.layers.Dense(input_size, name="dense_out")(output_states)

    model = tf.keras.Model(inputs=[signal_input, time_input], outputs=[y])

    print("compile model")
    base_lr = config["base_lr"]
    decay_lr = config["decay_lr"]
    train_steps = number_of_samples // config["batch_size"]
    learning_rate_fn = tf.keras.optimizers.schedules.ExponentialDecay(
        base_lr, train_steps, decay_lr
    )
    opt = (
        tf.keras.optimizers.Adam
        if config["optimizer"] == "adam"
        else tf.keras.optimizers.RMSprop
    )
    optimizer = opt(learning_rate_fn, clipnorm=config["clipnorm"])


    model.compile(
        optimizer = optimizer,
        loss=tf.keras.losses.MeanSquaredError(),
    )
    model.run_eagerly = True
    print("Executed create_float_model() successfully\n\n")

    model.summary()

    return model

def load_quant_walker(model_name, do_evaluation=True):
    print("\n\ncalled load_walker()")

    config = config_walker
    data = load_training_data()

    model = create_quant_model()

    if do_evaluation:
        # Evaluate untrained model for reference
        print("\n\nevaluate untrained model")
        test_loss = model.evaluate(
            x=(data.test_x, data.test_times), y=data.test_y, verbose=2
        )
        print(f"untrained model loss: {test_loss}")


    # Load trained model
    print("\n\nload trained model")
    model.load_weights(f'./data/{model_name}_checkpoint/{model_name}.h5')

    if do_evaluation:
        # Evaluate trained model
        print("evaluate trained model")
        test_loss = model.evaluate(
            x=(data.test_x, data.test_times), y=data.test_y, verbose=2
        )
        print(f"trained model loss: {test_loss}")

    print("Executed load_walker() successfully\n\n")
    return model, data