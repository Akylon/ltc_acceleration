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
Open Vitis with the workspace folder provided **WS/vitis/workspace**. Then import the vitis project archive zip **WS/vitis/vitis_export_archive.ide,zip**. Compiling it will result in an error, because the configuration file does currently not exist. As soon as the C model flow has been completed, the configuration file is available and thus this project is compilable.

### 2.4 Vitis HLS Project
Open Vitis HLS project located in directory **WS/vitis_hls/ltc_hls**. Then add a **new solution** for which the following settings must be set:
* Period = 300MHz
* Part/Board = Kria KV260 Vision AI Starter Kit SOM (xck26-sfvc784-2LV-c)
* Flow Target = Vivado IP Flow Target

### 2.5 Vitis HLS Cosimulation
The Cosimulation can check if the generated IP BLock behaves the same as the C Model. A problem with automising the test process, is that after each training session slightly different parameters are exported. This leads to small differences in the output with each newly exported configuration file.

The behaviour can be checked regardless by using the outputs observed in the C Simulation report. They must be manually added to the testbench model_test.cpp. For that copy the observed output from the C Simulation report to the variable "expected" in the testbench model_test.cpp. Since both the C Model and the Comsimulation are fed with the same input.

 the Cosimulation may be started to check if it behaves the same as the C Model. This requires that 


### 2.5 Vivado Project

### 3 Deploy Pipeline
The image below visualises the deploy pipeline. There are two flows of which the first results in a C model running on a single core of the Cortex-A53. The second flow results in the model running on the FPGA as a memory mapped accelerator.

![image](./readmeResources/pipeline.png)

#### 3.1 C Model Flow
1. Train the model using the script **WS/mdoel/training.py**, which trains and exports the model as an h5 file into the folder **WS/model/data/walker_relu_tanh_checkpoint**. This step is optional, because a pretrained h5 file is delivered in this workspace.
1. Generate the configuration file using the **WS/mdoel/export\_float\_model.py** script, which creates the file **WS/model/data/model\_export/walker\_relu\_tanh\_conifg.h**.
1. Open the Vitis project and compile the firmware without the hls\_model\_task, since it requires the quantised configuration file.

After setting up the solution the **C simulation** can be started. If it ran wihtout errors, then start the C Synthesis. When the synthesis completed successfully, then the IP Block can be exported using **Export RTL**. Export the IP Block into the folder **WS/ipBlock**. Unzip the exported zip folder at the same location.

#### 3.2 FGPA Flow
1. Train the model using the script **WS/mdoel/training.py**, which trains and exports the model as an h5 file into the folder **WS/model/data/walker_relu_tanh_checkpoint**. This step is optional, because a pretrained h5 file is delivered in this workspace.
2. Export validation data using the script **WS/model/export\_float\_validation.py**, which exports text files, containing the inputs and outputs of all layers for 1937 different samples, into the folder **WS/model/data/walker_relu_tanh_checkpoint/float_validation**.
3. Create the statistics data files using the script **WS/model/calculate\_shift\_stats.py**. These files are exported to folder **WS/model/data/model_quant_export**.
4. Generate the quantised configuration file using the script **WS/model/export\_quant\_model.py**, which creates the file **WS/model/data/model_quant_export/walker\_relu\_tanh\_quant\_conifg.h**.
5. Open the Vitis HLS project and run C simulation to execute all tests. If they pass continue with next step, else resolve issue. Note that changes, which purposefully alter the output behaviour, fail the tests. This is resolved by adjusting the test scripts.
6. Start synthesis with void model(...) as the top function. After it is finished check the synthesis report. If it is satisfactory then continue with next step, else optimise implementation.
7. **(Optional)**: If a the IP Block's behaviour must be tested, then follow the instructions of section **Vitis HLS Cosimulation** to set up the Cosimulation correctly. After which the Cosimulation can be executed and if the simulation passes then continue with the next step else resolve issue.
8. Export RTL as Vivado IP (.zip) to the folder **WS/ipBlock**. Unzip the exported file into the same folder.  Vitis \acrshort{hls} can be closed now.
9. Open the Vivado project and open the block diagram. In the block diagram replace 2D-Walker IP Block with your newly exported IP. For that make sure that the folder **WS/ipBlock** is added to the IP Catalogue. 
10. Connect the IP block and alter the clock provided by the processing system if necessary.
11. This should result in a block diagram similar to the following one:
    ![image](./readmeResources/blockDiagram.png)
12. Run synthesis and implementation. Check the implementation results afterwards, if no timing issues are present, then continue with the next step.
13. Generate and export hardware include the bit stream. Vivado can now be closed.
14. Open the Vitis project and update hardware specification with the new hardware file.
15. Compile the firmware without the c\_model\_task, since it requires the floating point configuration file.
16. 
#### 3.3 Run Application
1. Connect PC with Kria via JTAG programmer.
2. Connect PC with Kria via USB-2 Micro (J4) for serial communication using the UART interface of the Kria.
3. Plug the power up the Kria Platform.
4. Manually override bootmode to JTAG bootmode, since the Platform is per default in SD card bootmode. This can be done by typing the following commands into the XSCT console, while the Platform is connected via JTAG. More info about this is found [here](https://xilinx.github.io/kria-apps-docs/creating_applications/2022.1/build/html/docs/bootmodes.html).
   1. targets -set -filter {name=~ "PSU"}
   2. mwr 0xffca0010 0x0
   3. mwr 0xff5e0200 0x0100
   4. rst -system
5. Use a serial terminal of your choice and connect to the virtual serial port of the Kria Platform. Note that two ports will be visible and the UART is the Com Port with the lower number. The Parameters are:
    * Baud Rate: 115200
    * Data Bits: 8
    * Stop Bits: 1
    * Parity: None
    * Flow Control: None
6. 

















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
