-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScIz is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScIz is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "111111", 1 => "000010", 2 => "000011", 3 => "000011", 
    4 => "000000", 5 => "111011", 6 => "001001", 7 => "111100", 
    8 => "111110", 9 => "000000", 10 => "111001", 11 => "100000", 
    12 => "111101", 13 => "110100", 14 => "110101", 15 => "110100", 
    16 => "000000", 17 => "000100", 18 => "111010", 19 => "101100", 
    20 => "110111", 21 => "001010", 22 => "111101", 23 => "000101", 
    24 => "000010", 25 => "000010", 26 => "000101", 27 => "111110", 
    28 => "000011", 29 => "000010", 30 => "111100", 31 => "111100", 
    32 => "000000", 33 => "000001", 34 => "111101", 35 => "000110", 
    36 => "001100", 37 => "000001", 38 => "001000", 39 => "000100", 
    40 => "001101", 41 => "111001", 42 => "111111", 43 => "111110", 
    44 => "000101", 45 => "000100", 46 => "000110", 47 => "000010", 
    48 => "011010", 49 => "000000", 50 => "001100", 51 => "100111", 
    52 => "000001", 53 => "001011", 54 => "000101", 55 => "010111", 
    56 => "101101", 57 => "100100", 58 => "111101", 59 => "000001", 
    60 => "101100", 61 => "001010", 62 => "111101", 63 => "001010", 
    64 => "001011", 65 => "000001", 66 => "111011", 67 => "110100", 
    68 => "010000", 69 => "111111", 70 => "000000", 71 => "001100", 
    72 => "110100", 73 => "111111", 74 => "111101", 75 => "111000", 
    76 => "110110", 77 => "101010", 78 => "000111", 79 => "000111", 
    80 => "111110", 81 => "001000", 82 => "000101", 83 => "000100", 
    84 => "000100", 85 => "000001", 86 => "111110", 87 => "111001", 
    88 => "000000", 89 => "111001", 90 => "111100", 91 => "000110", 
    92 => "110111", 93 => "111011", 94 => "110010", 95 => "111111", 
    96 => "000001", 97 => "000010", 98 => "111111", 99 => "001111", 
    100 => "000111", 101 => "111010", 102 => "111101", 103 => "111110", 
    104 => "000000", 105 => "000010", 106 => "111000", 107 => "000011", 
    108 => "011100", 109 => "000101", 110 => "111110", 111 => "000011", 
    112 => "010000", 113 => "000111", 114 => "111010", 115 => "111000", 
    116 => "110110", 117 => "111011", 118 => "010010", 119 => "000100", 
    120 => "110110", 121 => "101100", 122 => "010100", 123 => "000101", 
    124 => "000101", 125 => "111100", 126 => "111101", 127 => "000010");



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

