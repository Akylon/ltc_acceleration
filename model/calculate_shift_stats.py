import os
import numpy as np

model_name = "walker_relu_tanh"
valDataPathLtc = "./data/walker_relu_tanh_checkpoint/float_validation/ltc/whitebox"
valDataPathDense = "./data/walker_relu_tanh_checkpoint/float_validation/dense_out/whitebox"
outputPath = "./data/model_quant_export"


paths = {"ltc": valDataPathLtc, "dense_out": valDataPathDense}


for superLayer, path in paths.items():
    files = os.listdir(path)

    data_dict = {}
    for file in files:
        if file[-4:] == ".npy":
            file_wihout_filetype = file[:-4]
            tokens = file_wihout_filetype.split(sep="_")
            ltc_part = tokens[0]
            type = tokens[-1]

            if type == "in":
                layer_name = "_".join(tokens[1:-1])
            else:
                layer_name = "_".join(tokens[1:-2])
                activation = tokens[-2]

            if ltc_part in ["ff1", "ff2", "ta", "tb"]:
                if not ltc_part in data_dict.keys():
                    data_dict[ltc_part] = {}
                if not layer_name in data_dict[ltc_part].keys():
                    data_dict[ltc_part][layer_name] = {}

                if type=="in":
                    data_dict[ltc_part][layer_name]["in"] = file
                else:
                    data_dict[ltc_part][layer_name][f"out_{activation}"] = file
            elif ltc_part in ["backbone"]:
                layer_name = layer_name.split(sep="_")
                isActivation = True if layer_name[0] == "Activation" else False
                layer_name[0] = "Dense"
                layer_name = "_".join(layer_name)

                if not ltc_part in data_dict.keys():
                    data_dict[ltc_part] = {}
                if not layer_name in data_dict[ltc_part].keys():
                    data_dict[ltc_part][layer_name] = {}

                if type=="in" and not isActivation:
                    data_dict[ltc_part][layer_name]["in"] = file
                elif type=="out":
                    data_dict[ltc_part][layer_name][f"out_{activation}"] = file

            elif ltc_part in ["denseout"]:
                if not ltc_part in data_dict.keys():
                    data_dict[ltc_part] = {}
                if not ltc_part in data_dict[ltc_part].keys():
                    data_dict[ltc_part][ltc_part] = {}

                if type=="in":
                    data_dict[ltc_part][ltc_part]["in"] = file
                else:
                    data_dict[ltc_part][ltc_part][f"out_{activation}"] = file


    print(data_dict)


    with open(outputPath+f"/{model_name}_{superLayer}_statistics.txt", "x") as fp:
        for sublayer, sublayer_data in data_dict.items():
            for layer_name, files in sublayer_data.items():
                fp.write(f"{layer_name} ")
                keys = files.keys()
                if "in" in keys:
                    data = np.load(path + "/" + files["in"])
                    if sublayer == "backbone" and layer_name[-2:] == "_0":
                        fp.write(f"in_sig {data[:, :, :17].min()} {data[:, :, :17].max()} ")
                        fp.write(f"in_state {data[:, :, 17:].min()} {data[:, :, 17:].max()} ")
                    else:
                        fp.write(f"in {data.min()} {data.max()} ")
                if "out_noActivation" in keys:
                    data = np.load(path + "/" + files["out_noActivation"])
                    fp.write(f"out_noActivation {data.min()} {data.max()} ")
                if "out_activation" in keys:
                    data = np.load(path + "/" + files["out_activation"])
                    fp.write(f"out_activation {data.min()} {data.max()} ")
                fp.write("\n")

