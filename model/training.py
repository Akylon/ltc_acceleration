from walker_model.train_walker import train_walker
from walker_model.create_load_float_model import create_float_model

model = create_float_model()

model = train_walker(model, "walker_relu_tanh")