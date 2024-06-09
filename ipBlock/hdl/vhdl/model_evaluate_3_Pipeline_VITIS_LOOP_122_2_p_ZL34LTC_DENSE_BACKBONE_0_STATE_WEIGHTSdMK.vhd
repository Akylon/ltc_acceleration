-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdMK is 
    generic(
             DataWidth     : integer := 6; 
             AddressWidth     : integer := 7; 
             AddressRange    : integer := 128
    ); 
    port (
 
          address0        : in std_logic_vector(AddressWidth-1 downto 0); 
          ce0             : in std_logic; 
          q0              : out std_logic_vector(DataWidth-1 downto 0);

          reset               : in std_logic;
          clk                 : in std_logic
    ); 
end entity; 


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdMK is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "001001", 1 => "001111", 2 => "000110", 3 => "101010", 
    4 => "000110", 5 => "111110", 6 => "111010", 7 => "111000", 
    8 => "110000", 9 => "001010", 10 => "001000", 11 => "110011", 
    12 => "110111", 13 => "111101", 14 => "111010", 15 => "000101", 
    16 => "110110", 17 => "001100", 18 => "101101", 19 => "110110", 
    20 => "111001", 21 => "000011", 22 => "000101", 23 => "111101", 
    24 => "000001", 25 => "000111", 26 => "010001", 27 => "010111", 
    28 => "110100", 29 => "000100", 30 => "000010", 31 => "110110", 
    32 => "001000", 33 => "000111", 34 => "101010", 35 => "110011", 
    36 => "000100", 37 => "000101", 38 => "110010", 39 => "110001", 
    40 => "101100", 41 => "001100", 42 => "000100", 43 => "000111", 
    44 => "000101", 45 => "101000", 46 => "110001", 47 => "000100", 
    48 => "101011", 49 => "111010", 50 => "110111", 51 => "111000", 
    52 => "111010", 53 => "111110", 54 => "111110", 55 => "111010", 
    56 => "110010", 57 => "111110", 58 => "010101", 59 => "000000", 
    60 => "110110", 61 => "110111", 62 => "110010", 63 => "010011", 
    64 => "010000", 65 => "111010", 66 => "110001", 67 => "110011", 
    68 => "001000", 69 => "110000", 70 => "010111", 71 => "111101", 
    72 => "111100", 73 => "001011", 74 => "000010", 75 => "110101", 
    76 => "010000", 77 => "001011", 78 => "110101", 79 => "111100", 
    80 => "001110", 81 => "100100", 82 => "001010", 83 => "101101", 
    84 => "000000", 85 => "111000", 86 => "111101", 87 => "010010", 
    88 => "111101", 89 => "011100", 90 => "101100", 91 => "111110", 
    92 => "000000", 93 => "000001", 94 => "101100", 95 => "101001", 
    96 => "000100", 97 => "111101", 98 => "111000", 99 => "010000", 
    100 => "110101", 101 => "000110", 102 => "001010", 103 => "000100", 
    104 => "111010", 105 => "101100", 106 => "000001", 107 => "111100", 
    108 => "000100", 109 => "000111", 110 => "000111", 111 => "111100", 
    112 => "011101", 113 => "111000", 114 => "101010", 115 => "110011", 
    116 => "111101", 117 => "111111", 118 => "000010", 119 => "110001", 
    120 => "111100", 121 => "110010", 122 => "011000", 123 => "000110", 
    124 => "000010", 125 => "110010", 126 => "111010", 127 => "110110");



begin 

 
memory_access_guard_0: process (address0) 
begin
      address0_tmp <= address0;
--synthesis translate_off
      if (CONV_INTEGER(address0) > AddressRange-1) then
           address0_tmp <= (others => '0');
      else 
           address0_tmp <= address0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
 
        if (ce0 = '1') then  
            q0 <= mem0(CONV_INTEGER(address0_tmp)); 
        end if;

end if;
end process;

end rtl;

