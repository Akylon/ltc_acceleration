-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSegO is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSegO is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "000110", 1 => "000111", 2 => "000011", 3 => "111110", 
    4 => "110110", 5 => "111110", 6 => "001000", 7 => "000100", 
    8 => "111011", 9 => "000100", 10 => "111111", 11 => "000000", 
    12 => "000010", 13 => "000111", 14 => "000010", 15 => "001011", 
    16 => "000100", 17 => "000010", 18 => "111010", 19 => "111100", 
    20 => "111110", 21 => "111100", 22 => "110100", 23 => "111011", 
    24 => "111110", 25 => "110110", 26 => "111111", 27 => "000000", 
    28 => "111100", 29 => "110110", 30 => "000000", 31 => "111101", 
    32 => "000001", 33 => "000100", 34 => "000011", 35 => "111100", 
    36 => "111101", 37 => "001000", 38 => "000101", 39 => "001011", 
    40 => "001010", 41 => "001010", 42 => "000011", 43 => "000010", 
    44 => "110111", 45 => "000011", 46 => "110101", 47 => "000111", 
    48 => "000110", 49 => "111011", 50 => "111010", 51 => "111100", 
    52 => "000100", 53 => "000001", 54 => "000001", 55 => "001100", 
    56 => "000101", 57 => "111110", 58 => "110101", 59 => "110100", 
    60 => "000111", 61 => "111000", 62 => "001010", 63 => "001011", 
    64 => "010100", 65 => "101001", 66 => "000011", 67 => "111110", 
    68 => "101011", 69 => "110111", 70 => "000001", 71 => "000110", 
    72 => "000001", 73 => "000101", 74 => "001110", 75 => "111001", 
    76 => "101101", 77 => "111001", 78 => "000110", 79 => "110001", 
    80 => "111101", 81 => "001111", 82 => "000010", 83 => "000101", 
    84 => "111011", 85 => "110011", 86 => "110111", 87 => "111101", 
    88 => "110101", 89 => "110111", 90 => "001100", 91 => "001100", 
    92 => "000111", 93 => "111101", 94 => "101101", 95 => "001001", 
    96 => "000001", 97 => "100110", 98 => "111001", 99 => "000110", 
    100 => "110111", 101 => "100010", 102 => "110100", 103 => "000110", 
    104 => "010101", 105 => "000101", 106 => "101101", 107 => "000011", 
    108 => "110011", 109 => "000011", 110 => "000101", 111 => "001100", 
    112 => "111010", 113 => "011000", 114 => "001010", 115 => "000001", 
    116 => "010110", 117 => "000000", 118 => "000001", 119 => "100111", 
    120 => "110100", 121 => "111010", 122 => "011011", 123 => "001011", 
    124 => "010000", 125 => "111010", 126 => "111101", 127 => "001101");



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

