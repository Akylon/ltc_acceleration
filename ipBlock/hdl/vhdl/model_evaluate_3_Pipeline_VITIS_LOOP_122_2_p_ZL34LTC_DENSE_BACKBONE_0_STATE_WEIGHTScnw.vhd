-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScnw is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScnw is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "11111101", 1 => "00000110", 2 => "11111111", 3 => "11111101", 
    4 => "00010011", 5 => "00000001", 6 => "11111000", 7 => "00010000", 
    8 => "11110000", 9 => "11110000", 10 => "00000110", 11 => "11111111", 
    12 => "00000110", 13 => "00100100", 14 => "00000011", 15 => "11100100", 
    16 => "00000111", 17 => "00011000", 18 => "11111110", 19 => "11111000", 
    20 => "11110111", 21 => "00000111", 22 => "11111011", 23 => "11110101", 
    24 => "00001011", 25 => "11111100", 26 => "11111011", 27 => "11111100", 
    28 => "00010111", 29 => "11101010", 30 => "11111010", 31 => "00001010", 
    32 => "11111110", 33 => "11111001", 34 => "11111110", 35 => "00001100", 
    36 => "00001011", 37 => "00001101", 38 => "11111001", 39 => "11111001", 
    40 => "00001110", 41 => "00001001", 42 => "00000100", 43 => "00011000", 
    44 => "00100100", 45 => "00000100", 46 => "00000100", 47 => "11111000", 
    48 => "00001100", 49 => "11111010", 50 => "00001000", 51 => "00001010", 
    52 => "00011101", 53 => "11110001", 54 => "00000111", 55 => "11101001", 
    56 => "11111101", 57 => "11001110", 58 => "00001101", 59 => "00000010", 
    60 => "11111100", 61 => "00001111", 62 => "11110011", 63 => "11110001", 
    64 => "00100000", 65 => "11111000", 66 => "00001111", 67 => "00001010", 
    68 => "00000000", 69 => "00000000", 70 => "00010011", 71 => "00001110", 
    72 => "11101100", 73 => "11001010", 74 => "00000010", 75 => "11100000", 
    76 => "11010011", 77 => "11100011", 78 => "00011101", 79 => "00011110", 
    80 => "00000100", 81 => "00001110", 82 => "00110001", 83 => "11011100", 
    84 => "11111110", 85 => "00000011", 86 => "11111100", 87 => "00000111", 
    88 => "11110001", 89 => "00001110", 90 => "11100111", 91 => "00011100", 
    92 => "00000110", 93 => "00011011", 94 => "11111010", 95 => "11110000", 
    96 => "00000010", 97 => "11110111", 98 => "00000100", 99 => "11101110", 
    100 => "00100011", 101 => "11101101", 102 => "11111101", 103 => "11110100", 
    104 => "00100101", 105 => "00000001", 106 => "11101110", 107 => "00001111", 
    108 => "01010110", 109 => "00001001", 110 => "11111101", 111 => "11110000", 
    112 => "00101000", 113 => "11110001", 114 => "00000110", 115 => "00010110", 
    116 => "11110000", 117 => "00000101", 118 => "00010111", 119 => "00011100", 
    120 => "11110101", 121 => "11100101", 122 => "00101100", 123 => "11110011", 
    124 => "11100101", 125 => "11101110", 126 => "11110010", 127 => "00010100");



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

