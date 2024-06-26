// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module model_calcTinterp (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        p_read,
        p_read1,
        p_read2,
        ap_return
);

parameter    ap_ST_fsm_state1 = 7'd1;
parameter    ap_ST_fsm_state2 = 7'd2;
parameter    ap_ST_fsm_state3 = 7'd4;
parameter    ap_ST_fsm_state4 = 7'd8;
parameter    ap_ST_fsm_state5 = 7'd16;
parameter    ap_ST_fsm_state6 = 7'd32;
parameter    ap_ST_fsm_state7 = 7'd64;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] p_read;
input  [7:0] p_read1;
input  [7:0] p_read2;
output  [7:0] ap_return;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[7:0] ap_return;

(* fsm_encoding = "none" *) reg   [6:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire    ap_CS_fsm_state3;
wire   [0:0] icmp_ln1027_fu_70_p2;
reg   [0:0] icmp_ln1027_reg_158;
wire    ap_CS_fsm_state4;
wire   [0:0] icmp_ln1035_fu_75_p2;
reg   [0:0] icmp_ln1035_reg_164;
wire  signed [8:0] sext_ln106_fu_48_p1;
wire  signed [8:0] sub_ln106_fu_56_p2;
wire  signed [15:0] grp_fu_123_p3;
wire  signed [20:0] result_V_fu_83_p1;
wire   [20:0] grp_fu_134_p3;
wire    ap_CS_fsm_state7;
wire   [0:0] xor_ln1027_fu_92_p2;
wire   [0:0] and_ln1035_fu_97_p2;
wire   [0:0] or_ln1035_fu_110_p2;
wire   [7:0] select_ln1035_fu_102_p3;
wire   [7:0] result_V_fu_83_p4;
wire   [15:0] grp_fu_134_p1;
wire   [18:0] grp_fu_134_p2;
wire    ap_CS_fsm_state6;
wire   [7:0] result_V_1538_fu_115_p3;
reg   [7:0] ap_return_preg;
reg   [6:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
wire    ap_ST_fsm_state4_blk;
wire    ap_ST_fsm_state5_blk;
wire    ap_ST_fsm_state6_blk;
wire    ap_ST_fsm_state7_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 7'd1;
#0 ap_return_preg = 8'd0;
end

model_mac_muladd_8s_9s_8s_16_4_1 #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 9 ),
    .din2_WIDTH( 8 ),
    .dout_WIDTH( 16 ))
mac_muladd_8s_9s_8s_16_4_1_U2037(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(p_read1),
    .din1(sub_ln106_fu_56_p2),
    .din2(p_read2),
    .ce(1'b1),
    .dout(grp_fu_123_p3)
);

model_mac_muladd_16s_16ns_19ns_21_4_1 #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 16 ),
    .din2_WIDTH( 19 ),
    .dout_WIDTH( 21 ))
mac_muladd_16s_16ns_19ns_21_4_1_U2038(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_123_p3),
    .din1(grp_fu_134_p1),
    .din2(grp_fu_134_p2),
    .ce(1'b1),
    .dout(grp_fu_134_p3)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_return_preg <= 8'd0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state7)) begin
            ap_return_preg <= result_V_1538_fu_115_p3;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        icmp_ln1027_reg_158 <= icmp_ln1027_fu_70_p2;
        icmp_ln1035_reg_164 <= icmp_ln1035_fu_75_p2;
    end
end

always @ (*) begin
    if ((ap_start == 1'b0)) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state2_blk = 1'b0;

assign ap_ST_fsm_state3_blk = 1'b0;

assign ap_ST_fsm_state4_blk = 1'b0;

assign ap_ST_fsm_state5_blk = 1'b0;

assign ap_ST_fsm_state6_blk = 1'b0;

assign ap_ST_fsm_state7_blk = 1'b0;

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state7) | ((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state7)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state7)) begin
        ap_return = result_V_1538_fu_115_p3;
    end else begin
        ap_return = ap_return_preg;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign and_ln1035_fu_97_p2 = (xor_ln1027_fu_92_p2 & icmp_ln1035_reg_164);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];

assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];

assign grp_fu_134_p1 = 21'd43690;

assign grp_fu_134_p2 = 21'd262144;

assign icmp_ln1027_fu_70_p2 = (($signed(grp_fu_123_p3) < $signed(16'd65530)) ? 1'b1 : 1'b0);

assign icmp_ln1035_fu_75_p2 = (($signed(grp_fu_123_p3) > $signed(16'd6)) ? 1'b1 : 1'b0);

assign or_ln1035_fu_110_p2 = (icmp_ln1027_reg_158 | and_ln1035_fu_97_p2);

assign result_V_1538_fu_115_p3 = ((or_ln1035_fu_110_p2[0:0] == 1'b1) ? select_ln1035_fu_102_p3 : result_V_fu_83_p4);

assign result_V_fu_83_p1 = grp_fu_134_p3;

assign result_V_fu_83_p4 = {{result_V_fu_83_p1[20:13]}};

assign select_ln1035_fu_102_p3 = ((and_ln1035_fu_97_p2[0:0] == 1'b1) ? 8'd64 : 8'd0);

assign sext_ln106_fu_48_p1 = $signed(p_read);

assign sub_ln106_fu_56_p2 = ($signed(9'd0) - $signed(sext_ln106_fu_48_p1));

assign xor_ln1027_fu_92_p2 = (icmp_ln1027_reg_158 ^ 1'd1);

endmodule //model_calcTinterp
