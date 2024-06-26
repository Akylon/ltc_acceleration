-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity model_calcTinterp is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    p_read : IN STD_LOGIC_VECTOR (7 downto 0);
    p_read1 : IN STD_LOGIC_VECTOR (7 downto 0);
    p_read2 : IN STD_LOGIC_VECTOR (7 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (7 downto 0) );
end;


architecture behav of model_calcTinterp is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (6 downto 0) := "0000001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (6 downto 0) := "0000010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (6 downto 0) := "0000100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (6 downto 0) := "0001000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (6 downto 0) := "0010000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (6 downto 0) := "0100000";
    constant ap_ST_fsm_state7 : STD_LOGIC_VECTOR (6 downto 0) := "1000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv9_0 : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
    constant ap_const_lv16_FFFA : STD_LOGIC_VECTOR (15 downto 0) := "1111111111111010";
    constant ap_const_lv16_6 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000110";
    constant ap_const_lv32_D : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001101";
    constant ap_const_lv32_14 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010100";
    constant ap_const_lv32_6 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000110";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv8_40 : STD_LOGIC_VECTOR (7 downto 0) := "01000000";
    constant ap_const_lv8_0 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    constant ap_const_lv21_AAAA : STD_LOGIC_VECTOR (20 downto 0) := "000001010101010101010";
    constant ap_const_lv21_40000 : STD_LOGIC_VECTOR (20 downto 0) := "001000000000000000000";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (6 downto 0) := "0000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal icmp_ln1027_fu_70_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1027_reg_158 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal icmp_ln1035_fu_75_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1035_reg_164 : STD_LOGIC_VECTOR (0 downto 0);
    signal sext_ln106_fu_48_p1 : STD_LOGIC_VECTOR (8 downto 0);
    signal sub_ln106_fu_56_p2 : STD_LOGIC_VECTOR (8 downto 0);
    signal grp_fu_123_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal result_V_fu_83_p1 : STD_LOGIC_VECTOR (20 downto 0);
    signal grp_fu_134_p3 : STD_LOGIC_VECTOR (20 downto 0);
    signal ap_CS_fsm_state7 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state7 : signal is "none";
    signal xor_ln1027_fu_92_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln1035_fu_97_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln1035_fu_110_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal select_ln1035_fu_102_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal result_V_fu_83_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_fu_134_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_134_p2 : STD_LOGIC_VECTOR (18 downto 0);
    signal ap_CS_fsm_state6 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state6 : signal is "none";
    signal result_V_1538_fu_115_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal ap_return_preg : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (6 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal ap_ST_fsm_state5_blk : STD_LOGIC;
    signal ap_ST_fsm_state6_blk : STD_LOGIC;
    signal ap_ST_fsm_state7_blk : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component model_mac_muladd_8s_9s_8s_16_4_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        din2_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (7 downto 0);
        din1 : IN STD_LOGIC_VECTOR (8 downto 0);
        din2 : IN STD_LOGIC_VECTOR (7 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (15 downto 0) );
    end component;


    component model_mac_muladd_16s_16ns_19ns_21_4_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        din2_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (15 downto 0);
        din1 : IN STD_LOGIC_VECTOR (15 downto 0);
        din2 : IN STD_LOGIC_VECTOR (18 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (20 downto 0) );
    end component;



begin
    mac_muladd_8s_9s_8s_16_4_1_U2037 : component model_mac_muladd_8s_9s_8s_16_4_1
    generic map (
        ID => 1,
        NUM_STAGE => 4,
        din0_WIDTH => 8,
        din1_WIDTH => 9,
        din2_WIDTH => 8,
        dout_WIDTH => 16)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => p_read1,
        din1 => sub_ln106_fu_56_p2,
        din2 => p_read2,
        ce => ap_const_logic_1,
        dout => grp_fu_123_p3);

    mac_muladd_16s_16ns_19ns_21_4_1_U2038 : component model_mac_muladd_16s_16ns_19ns_21_4_1
    generic map (
        ID => 1,
        NUM_STAGE => 4,
        din0_WIDTH => 16,
        din1_WIDTH => 16,
        din2_WIDTH => 19,
        dout_WIDTH => 21)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_123_p3,
        din1 => grp_fu_134_p1,
        din2 => grp_fu_134_p2,
        ce => ap_const_logic_1,
        dout => grp_fu_134_p3);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_return_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_return_preg <= ap_const_lv8_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
                    ap_return_preg <= result_V_1538_fu_115_p3;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state4)) then
                icmp_ln1027_reg_158 <= icmp_ln1027_fu_70_p2;
                icmp_ln1035_reg_164 <= icmp_ln1035_fu_75_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state5;
            when ap_ST_fsm_state5 => 
                ap_NS_fsm <= ap_ST_fsm_state6;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when ap_ST_fsm_state7 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXXXXX";
        end case;
    end process;
    and_ln1035_fu_97_p2 <= (xor_ln1027_fu_92_p2 and icmp_ln1035_reg_164);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);
    ap_CS_fsm_state6 <= ap_CS_fsm(5);
    ap_CS_fsm_state7 <= ap_CS_fsm(6);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start)
    begin
        if ((ap_start = ap_const_logic_0)) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state2_blk <= ap_const_logic_0;
    ap_ST_fsm_state3_blk <= ap_const_logic_0;
    ap_ST_fsm_state4_blk <= ap_const_logic_0;
    ap_ST_fsm_state5_blk <= ap_const_logic_0;
    ap_ST_fsm_state6_blk <= ap_const_logic_0;
    ap_ST_fsm_state7_blk <= ap_const_logic_0;

    ap_done_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state7)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state7) or ((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state7)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_return_assign_proc : process(ap_CS_fsm_state7, result_V_1538_fu_115_p3, ap_return_preg)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
            ap_return <= result_V_1538_fu_115_p3;
        else 
            ap_return <= ap_return_preg;
        end if; 
    end process;

    grp_fu_134_p1 <= ap_const_lv21_AAAA(16 - 1 downto 0);
    grp_fu_134_p2 <= ap_const_lv21_40000(19 - 1 downto 0);
    icmp_ln1027_fu_70_p2 <= "1" when (signed(grp_fu_123_p3) < signed(ap_const_lv16_FFFA)) else "0";
    icmp_ln1035_fu_75_p2 <= "1" when (signed(grp_fu_123_p3) > signed(ap_const_lv16_6)) else "0";
    or_ln1035_fu_110_p2 <= (icmp_ln1027_reg_158 or and_ln1035_fu_97_p2);
    result_V_1538_fu_115_p3 <= 
        select_ln1035_fu_102_p3 when (or_ln1035_fu_110_p2(0) = '1') else 
        result_V_fu_83_p4;
    result_V_fu_83_p1 <= grp_fu_134_p3;
    result_V_fu_83_p4 <= result_V_fu_83_p1(20 downto 13);
    select_ln1035_fu_102_p3 <= 
        ap_const_lv8_40 when (and_ln1035_fu_97_p2(0) = '1') else 
        ap_const_lv8_0;
        sext_ln106_fu_48_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(p_read),9));

    sub_ln106_fu_56_p2 <= std_logic_vector(unsigned(ap_const_lv9_0) - unsigned(sext_ln106_fu_48_p1));
    xor_ln1027_fu_92_p2 <= (icmp_ln1027_reg_158 xor ap_const_lv1_1);
end behav;
