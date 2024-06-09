// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module model_evaluate_7_Pipeline_VITIS_LOOP_122_2_DENSE_OUT_WEIGHTS_V_ROM_AUTO_1R (
    address0, ce0, q0, 
    address1, ce1, q1, 
    reset, clk);

parameter DataWidth = 8;
parameter AddressWidth = 11;
parameter AddressRange = 1088;
 
input[AddressWidth-1:0] address0;
input ce0;
output reg[DataWidth-1:0] q0;
 
input[AddressWidth-1:0] address1;
input ce1;
output reg[DataWidth-1:0] q1;

input reset;
input clk;

 
reg [DataWidth-1:0] rom0[0:AddressRange-1];


initial begin
     
    $readmemh("./model_evaluate_7_Pipeline_VITIS_LOOP_122_2_DENSE_OUT_WEIGHTS_V_ROM_AUTO_1R.dat", rom0);
end

  
always @(posedge clk) 
begin 
    if (ce0) 
    begin
        q0 <= rom0[address0];
    end
end
  
always @(posedge clk) 
begin 
    if (ce1) 
    begin
        q1 <= rom0[address1];
    end
end


endmodule

