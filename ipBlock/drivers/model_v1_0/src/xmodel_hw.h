// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 7  - auto_restart (Read/Write)
//        bit 9  - interrupt (Read)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0 - enable ap_done interrupt (Read/Write)
//        bit 1 - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0 - ap_done (Read/TOW)
//        bit 1 - ap_ready (Read/TOW)
//        others - reserved
// 0x10 : Data signal of signalIn_reg
//        bit 31~0 - signalIn_reg[31:0] (Read/Write)
// 0x14 : Data signal of signalIn_reg
//        bit 31~0 - signalIn_reg[63:32] (Read/Write)
// 0x18 : Data signal of signalIn_reg
//        bit 31~0 - signalIn_reg[95:64] (Read/Write)
// 0x1c : Data signal of signalIn_reg
//        bit 31~0 - signalIn_reg[127:96] (Read/Write)
// 0x20 : Data signal of signalIn_reg
//        bit 7~0 - signalIn_reg[135:128] (Read/Write)
//        others  - reserved
// 0x24 : reserved
// 0x28 : Data signal of timeIn_reg
//        bit 7~0 - timeIn_reg[7:0] (Read/Write)
//        others  - reserved
// 0x2c : reserved
// 0x30 : Data signal of output_reg
//        bit 31~0 - output_reg[31:0] (Read)
// 0x34 : Data signal of output_reg
//        bit 31~0 - output_reg[63:32] (Read)
// 0x38 : Data signal of output_reg
//        bit 31~0 - output_reg[95:64] (Read)
// 0x3c : Data signal of output_reg
//        bit 31~0 - output_reg[127:96] (Read)
// 0x40 : Data signal of output_reg
//        bit 7~0 - output_reg[135:128] (Read)
//        others  - reserved
// 0x44 : Control signal of output_reg
//        bit 0  - output_reg_ap_vld (Read/COR)
//        others - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XMODEL_CONTROL_ADDR_AP_CTRL           0x00
#define XMODEL_CONTROL_ADDR_GIE               0x04
#define XMODEL_CONTROL_ADDR_IER               0x08
#define XMODEL_CONTROL_ADDR_ISR               0x0c
#define XMODEL_CONTROL_ADDR_SIGNALIN_REG_DATA 0x10
#define XMODEL_CONTROL_BITS_SIGNALIN_REG_DATA 136
#define XMODEL_CONTROL_ADDR_TIMEIN_REG_DATA   0x28
#define XMODEL_CONTROL_BITS_TIMEIN_REG_DATA   8
#define XMODEL_CONTROL_ADDR_OUTPUT_REG_DATA   0x30
#define XMODEL_CONTROL_BITS_OUTPUT_REG_DATA   136
#define XMODEL_CONTROL_ADDR_OUTPUT_REG_CTRL   0x44

