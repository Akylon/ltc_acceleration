-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScRA is 
    generic(
             DataWidth     : integer := 8; 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScRA is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "00000100", 1 => "00000001", 2 => "11111111", 3 => "11110101", 
    4 => "00000110", 5 => "00001000", 6 => "00000100", 7 => "11111111", 
    8 => "11111010", 9 => "00000010", 10 => "11111011", 11 => "11101111", 
    12 => "11111001", 13 => "11111011", 14 => "00001001", 15 => "00000011", 
    16 => "00000001", 17 => "00000111", 18 => "11110110", 19 => "00000101", 
    20 => "11111101", 21 => "00000100", 22 => "11111010", 23 => "00000101", 
    24 => "00000010", 25 => "11101101", 26 => "11111000", 27 => "00000110", 
    28 => "00000011", 29 => "00000001", 30 => "00000101", 31 => "11101101", 
    32 => "00000111", 33 => "00001110", 34 => "00000000", 35 => "11111010", 
    36 => "00001110", 37 => "00000001", 38 => "00000000", 39 => "00000111", 
    40 => "11110111", 41 => "00000000", 42 => "00000100", 43 => "00001010", 
    44 => "11111111", 45 => "00000011", 46 => "11111101", 47 => "00000100", 
    48 => "00000110", 49 => "00000110", 50 => "00000011", 51 => "11100110", 
    52 => "00000111", 53 => "11110000", 54 => "00001001", 55 => "11111100", 
    56 => "11101001", 57 => "11111001", 58 => "00011101", 59 => "00000001", 
    60 => "11111111", 61 => "11111000", 62 => "11111011", 63 => "00000001", 
    64 => "00001000", 65 => "00000011", 66 => "00011000", 67 => "11110111", 
    68 => "11110011", 69 => "11001100", 70 => "11110000", 71 => "00001000", 
    72 => "11000110", 73 => "11011001", 74 => "00000100", 75 => "11011101", 
    76 => "11111001", 77 => "00111010", 78 => "10111100", 79 => "11101100", 
    80 => "00100000", 81 => "11111100", 82 => "11100101", 83 => "11101010", 
    84 => "11111111", 85 => "11111010", 86 => "00111000", 87 => "11111101", 
    88 => "00000010", 89 => "11100110", 90 => "11100111", 91 => "11001100", 
    92 => "11111010", 93 => "11101000", 94 => "11111111", 95 => "11101010", 
    96 => "00000000", 97 => "00001100", 98 => "00010111", 99 => "00100000", 
    100 => "00001100", 101 => "11101100", 102 => "11111000", 103 => "00010100", 
    104 => "00100011", 105 => "11111101", 106 => "11101110", 107 => "01000001", 
    108 => "00010000", 109 => "00000001", 110 => "11100001", 111 => "00000011", 
    112 => "00000101", 113 => "11111101", 114 => "00001111", 115 => "01000011", 
    116 => "11111001", 117 => "00011100", 118 => "00000110", 119 => "11101010", 
    120 => "11101001", 121 => "10111100", 122 => "00100000", 123 => "11110001", 
    124 => "11100010", 125 => "11101010", 126 => "11100011", 127 => "11100110");



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

