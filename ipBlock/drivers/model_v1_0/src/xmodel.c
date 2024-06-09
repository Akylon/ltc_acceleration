// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xmodel.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XModel_CfgInitialize(XModel *InstancePtr, XModel_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XModel_Start(XModel *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_AP_CTRL) & 0x80;
    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XModel_IsDone(XModel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XModel_IsIdle(XModel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XModel_IsReady(XModel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XModel_EnableAutoRestart(XModel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XModel_DisableAutoRestart(XModel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_AP_CTRL, 0);
}

void XModel_Set_signalIn_reg(XModel *InstancePtr, XModel_Signalin_reg Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_SIGNALIN_REG_DATA + 0, Data.word_0);
    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_SIGNALIN_REG_DATA + 4, Data.word_1);
    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_SIGNALIN_REG_DATA + 8, Data.word_2);
    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_SIGNALIN_REG_DATA + 12, Data.word_3);
    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_SIGNALIN_REG_DATA + 16, Data.word_4);
}

XModel_Signalin_reg XModel_Get_signalIn_reg(XModel *InstancePtr) {
    XModel_Signalin_reg Data;

    Data.word_0 = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_SIGNALIN_REG_DATA + 0);
    Data.word_1 = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_SIGNALIN_REG_DATA + 4);
    Data.word_2 = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_SIGNALIN_REG_DATA + 8);
    Data.word_3 = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_SIGNALIN_REG_DATA + 12);
    Data.word_4 = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_SIGNALIN_REG_DATA + 16);
    return Data;
}

void XModel_Set_timeIn_reg(XModel *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_TIMEIN_REG_DATA, Data);
}

u32 XModel_Get_timeIn_reg(XModel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_TIMEIN_REG_DATA);
    return Data;
}

XModel_Output_reg XModel_Get_output_reg(XModel *InstancePtr) {
    XModel_Output_reg Data;

    Data.word_0 = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_OUTPUT_REG_DATA + 0);
    Data.word_1 = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_OUTPUT_REG_DATA + 4);
    Data.word_2 = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_OUTPUT_REG_DATA + 8);
    Data.word_3 = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_OUTPUT_REG_DATA + 12);
    Data.word_4 = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_OUTPUT_REG_DATA + 16);
    return Data;
}

u32 XModel_Get_output_reg_vld(XModel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_OUTPUT_REG_CTRL);
    return Data & 0x1;
}

void XModel_InterruptGlobalEnable(XModel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_GIE, 1);
}

void XModel_InterruptGlobalDisable(XModel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_GIE, 0);
}

void XModel_InterruptEnable(XModel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_IER);
    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_IER, Register | Mask);
}

void XModel_InterruptDisable(XModel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_IER);
    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_IER, Register & (~Mask));
}

void XModel_InterruptClear(XModel *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XModel_WriteReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_ISR, Mask);
}

u32 XModel_InterruptGetEnabled(XModel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_IER);
}

u32 XModel_InterruptGetStatus(XModel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XModel_ReadReg(InstancePtr->Control_BaseAddress, XMODEL_CONTROL_ADDR_ISR);
}

