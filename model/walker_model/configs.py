# data params
data_config = { 
    "seq_len" : 64,
    "input_size" : 17,
    "number_of_samples" : 9684,
    }


config_walker = {
    "clipnorm": 1,
    "optimizer": "adam",
    "batch_size": 256,
    "size": 64,
    "epochs": 50,
    "base_lr": 0.02,
    "decay_lr": 0.95,
    "backbone_activation": "relu",
    "backbone_dr": 0.1,
    "forget_bias": 1.6,
    "backbone_units": 256,
    "backbone_layers": 1,
    "weight_decay": 1e-06,
    "use_mixed": False,
}