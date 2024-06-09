-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdFJ is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdFJ is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "000011", 1 => "111101", 2 => "000001", 3 => "111010", 
    4 => "000011", 5 => "111000", 6 => "001000", 7 => "111101", 
    8 => "110011", 9 => "000000", 10 => "000011", 11 => "111001", 
    12 => "111100", 13 => "111101", 14 => "001110", 15 => "001010", 
    16 => "000010", 17 => "111001", 18 => "111101", 19 => "110100", 
    20 => "000001", 21 => "110101", 22 => "111110", 23 => "111110", 
    24 => "011000", 25 => "110110", 26 => "000000", 27 => "111101", 
    28 => "000000", 29 => "110110", 30 => "000111", 31 => "000010", 
    32 => "111101", 33 => "001000", 34 => "111100", 35 => "000110", 
    36 => "000111", 37 => "111101", 38 => "001001", 39 => "111110", 
    40 => "001001", 41 => "000111", 42 => "000011", 43 => "000101", 
    44 => "001010", 45 => "000100", 46 => "111001", 47 => "111110", 
    48 => "111010", 49 => "111110", 50 => "000100", 51 => "100001", 
    52 => "010000", 53 => "001001", 54 => "000101", 55 => "000110", 
    56 => "110110", 57 => "111101", 58 => "111111", 59 => "111010", 
    60 => "111101", 61 => "000010", 62 => "000000", 63 => "111110", 
    64 => "010000", 65 => "000000", 66 => "000000", 67 => "110101", 
    68 => "000011", 69 => "111000", 70 => "000001", 71 => "000011", 
    72 => "111010", 73 => "001010", 74 => "111010", 75 => "110010", 
    76 => "111111", 77 => "011010", 78 => "010011", 79 => "111111", 
    80 => "111111", 81 => "000100", 82 => "101111", 83 => "101010", 
    84 => "101100", 85 => "110001", 86 => "111101", 87 => "111001", 
    88 => "111000", 89 => "101011", 90 => "111111", 91 => "111011", 
    92 => "001001", 93 => "000000", 94 => "110010", 95 => "110100", 
    96 => "111010", 97 => "010001", 98 => "000110", 99 => "000000", 
    100 => "111110", 101 => "000000", 102 => "001010", 103 => "111010", 
    104 => "110111", 105 => "111001", 106 => "110011", 107 => "011010", 
    108 => "010000", 109 => "000111", 110 => "111100", 111 => "000101", 
    112 => "000001", 113 => "111000", 114 => "111100", 115 => "000100", 
    116 => "111100", 117 => "000100", 118 => "000100", 119 => "101110", 
    120 => "001101", 121 => "110000", 122 => "111111", 123 => "001000", 
    124 => "000000", 125 => "110110", 126 => "111110", 127 => "000000");



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

