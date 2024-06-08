# Liquid Time Neural Networks on Embedded Devices

## 1 Folder Structure
This readme file requires to specify folder and file locations, for which the variable WS is introduced. WS relates to the source folder, with which for example the readem location can be specified with WS/README.md.

## 2 Setup

### 2.1 Tools
- Python
- TensorFlow 2.10.0 or later. (The newest version of TensorFlow does not work with the scripts provided.)
- Vitis 2022.2
- Vitis HLS 2022.2
- Vivado 2022.2
- 
### 2.2 Downloading the Dataset
The first thing is to download the training dataset, by calling the file donwload_dataset.sh in a bash console with
```bash
source download_dataset.sh
```
If errors occur or no bash console is available, download the dataset manually from "https://people.csail.mit.edu/mlechner/datasets/walker.zip" and unzip the zip file into WS/data/walker, such that the .npy files are located in folder WS/data/walker.

### 2.3 Vitis Project
Open Vitis with the workspace folder provided **WS/vitis/workspace**. The import the vitis project archive zip **WS/vitis/vitis_export_archive.ide,zip**. Compiling it will result in an error, because the configuration file does currently not exist. As soon as the C model flow has been completed, the configuration file is available and thus this project is compilable.

### 2.4 Vitis HLS Project

### 2.5 Vivado Project

### 3 Deploy Pipeline
The image below visualises the deploy pipeline. There are two flows of which the first results in a C model running on a single core of the Cortex-A53. The second flow results in the model running on the FPGA as a memory mapped accelerator.

![image](./readmeResources/pipeline.png)

#### 3.1 C Model Flow
1. Train the model using the script **WS/mdoel/training.py**, which trains and exports the model as an h5 file into the folder **WS/model/data/walker_relu_tanh_checkpoint**. This step is optional, because a pretrained h5 file is delivered in this workspace.
1. Generate the configuration file using the **WS/mdoel/export\_float\_model.py** script, which creates the file **WS/model/data/model\_export/walker\_relu\_tanh\_conifg.h**.
1. Open the Vitis project and compile the firmware without the hls\_model\_task, since it requires the quantised configuration file.
#### 3.2 FGPA Flow
1. Open the Vitis project and compile the firmware without the hls\_model\_task, since it requires the quantised configuration file.
2. Export validation data using the script **WS/model/export\_float\_validation.py**, which exports text files, containing the inputs and outputs of all layers for 1937 different samples, into the folder **WS/model/data/walker_relu_tanh_checkpoint/float_validation**.
3. Create the statistics data files using the script **WS/model/calculate\_shift\_stats.py**. These files are exported to folder **WS/model/data/model_quant_export**.
4. Generate the quantised configuration file using the script **WS/model/export\_quant\_model.py**, which creates the file **WS/model/data/model_quant_export/walker\_relu\_tanh\_quant\_conifg.h**.
5. Open the Vitis HLS project and run C simulation to execute all tests. If they pass continue with next step, else resolve issue. Note that changes, which purposefully alter the output behaviour fail the tests. This is resolved by adjusting the test scripts.
6. Start synthesis with void model(\dots) as the top function. After it is finished check the synthesis report. If it is satisfactory then continue with next step, else optimise implementation.
7. Start Cosimulation to check if synthesised design does the same as the C/C++ code. If it passes then continue with next step, else resolve error.
8. Export RTL as Vivado IP (.zip) and move the zip file to the folder ipBlock. Within this folder delete all non zip files and then unzip the zip file. Vitis \acrshort{hls} can be closed now.
9. Open the Vivado project and open the block diagram. In the block diagram upgrade the walker model IP or delete it and add the new version. Note that if the IP is not found in the IP catalogue then adding the folder ipBlock to the catalogue should resolve this.
10. Connect the IP block and alter the clock provided by the processing system if necessary.
11. Run synthesis and implementation. Check the implementation results afterwards, if no timing issues are present, then continue with the next step.
12. Generate and export hardware include the bit stream. Vivado can now be closed.
13. Open the Vitis project and update hardware specification with the new hardware file.
14. Compile the firmware without the c\_model\_task, since it requires the floating point configuration file.

















## Cite

```
@article{hasani_closed-form_2022,
	title = {Closed-form continuous-time neural networks},
	journal = {Nature Machine Intelligence},
	author = {Hasani, Ramin and Lechner, Mathias and Amini, Alexander and Liebenwein, Lucas and Ray, Aaron and Tschaikowski, Max and Teschl, Gerald and Rus, Daniela},
	issn = {2522-5839},
	month = nov,
	year = {2022},
}
```
