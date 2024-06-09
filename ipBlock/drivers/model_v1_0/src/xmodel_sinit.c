// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xmodel.h"

extern XModel_Config XModel_ConfigTable[];

XModel_Config *XModel_LookupConfig(u16 DeviceId) {
	XModel_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XMODEL_NUM_INSTANCES; Index++) {
		if (XModel_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XModel_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XModel_Initialize(XModel *InstancePtr, u16 DeviceId) {
	XModel_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XModel_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XModel_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

