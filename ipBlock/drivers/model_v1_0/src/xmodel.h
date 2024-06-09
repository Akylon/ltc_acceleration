// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XMODEL_H
#define XMODEL_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xmodel_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u64 Control_BaseAddress;
} XModel_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XModel;

typedef u32 word_type;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
    u32 word_4;
} XModel_Signalin_reg;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
    u32 word_4;
} XModel_Output_reg;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XModel_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XModel_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XModel_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XModel_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XModel_Initialize(XModel *InstancePtr, u16 DeviceId);
XModel_Config* XModel_LookupConfig(u16 DeviceId);
int XModel_CfgInitialize(XModel *InstancePtr, XModel_Config *ConfigPtr);
#else
int XModel_Initialize(XModel *InstancePtr, const char* InstanceName);
int XModel_Release(XModel *InstancePtr);
#endif

void XModel_Start(XModel *InstancePtr);
u32 XModel_IsDone(XModel *InstancePtr);
u32 XModel_IsIdle(XModel *InstancePtr);
u32 XModel_IsReady(XModel *InstancePtr);
void XModel_EnableAutoRestart(XModel *InstancePtr);
void XModel_DisableAutoRestart(XModel *InstancePtr);

void XModel_Set_signalIn_reg(XModel *InstancePtr, XModel_Signalin_reg Data);
XModel_Signalin_reg XModel_Get_signalIn_reg(XModel *InstancePtr);
void XModel_Set_timeIn_reg(XModel *InstancePtr, u32 Data);
u32 XModel_Get_timeIn_reg(XModel *InstancePtr);
XModel_Output_reg XModel_Get_output_reg(XModel *InstancePtr);
u32 XModel_Get_output_reg_vld(XModel *InstancePtr);

void XModel_InterruptGlobalEnable(XModel *InstancePtr);
void XModel_InterruptGlobalDisable(XModel *InstancePtr);
void XModel_InterruptEnable(XModel *InstancePtr, u32 Mask);
void XModel_InterruptDisable(XModel *InstancePtr, u32 Mask);
void XModel_InterruptClear(XModel *InstancePtr, u32 Mask);
u32 XModel_InterruptGetEnabled(XModel *InstancePtr);
u32 XModel_InterruptGetStatus(XModel *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
