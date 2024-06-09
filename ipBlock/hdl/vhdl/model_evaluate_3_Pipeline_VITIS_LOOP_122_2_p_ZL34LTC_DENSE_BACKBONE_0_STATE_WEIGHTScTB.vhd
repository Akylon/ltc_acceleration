-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScTB is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScTB is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "11110001", 1 => "11111001", 2 => "00011100", 3 => "00000000", 
    4 => "11111001", 5 => "00011011", 6 => "00100010", 7 => "00010011", 
    8 => "00000001", 9 => "00001110", 10 => "00001100", 11 => "11101010", 
    12 => "11101011", 13 => "00001101", 14 => "11110111", 15 => "11110101", 
    16 => "11101100", 17 => "00001101", 18 => "00000000", 19 => "11011111", 
    20 => "00001010", 21 => "00001100", 22 => "11110011", 23 => "11110000", 
    24 => "00001001", 25 => "11110101", 26 => "11110011", 27 => "00110010", 
    28 => "11110000", 29 => "11110010", 30 => "00101011", 31 => "11100101", 
    32 => "11010111", 33 => "11001111", 34 => "11100100", 35 => "00001011", 
    36 => "11110111", 37 => "11100111", 38 => "11111111", 39 => "00001110", 
    40 => "00000001", 41 => "00010010", 42 => "01000101", 43 => "00010010", 
    44 => "11110111", 45 => "11011101", 46 => "11101111", 47 => "00001000", 
    48 => "11101100", 49 => "11111011", 50 => "00100100", 51 => "00000101", 
    52 => "11011111", 53 => "00100101", 54 => "00011001", 55 => "11110011", 
    56 => "00000111", 57 => "11100010", 58 => "00010111", 59 => "00011111", 
    60 => "11111100", 61 => "00000001", 62 => "11100111", 63 => "00001000", 
    64 => "00000001", 65 => "00000010", 66 => "11111100", 67 => "00000110", 
    68 => "00000010", 69 => "00000000", 70 => "00001100", 71 => "00000000", 
    72 => "11111010", 73 => "00000111", 74 => "11111101", 75 => "00000001", 
    76 => "11111010", 77 => "00000000", 78 => "11111100", 79 => "00010001", 
    80 => "00001011", 81 => "00010100", 82 => "11110001", 83 => "11111011", 
    84 => "11110111", 85 => "00000000", 86 => "00000010", 87 => "11110011", 
    88 => "00001001", 89 => "11111100", 90 => "00001000", 91 => "11111110", 
    92 => "00000010", 93 => "11110001", 94 => "00010111", 95 => "11111000", 
    96 => "11111110", 97 => "00010010", 98 => "00000100", 99 => "11111110", 
    100 => "00001000", 101 => "00000011", 102 => "11110110", 103 => "00001100", 
    104 => "00000111", 105 => "00000100", 106 => "00000111", 107 => "00000001", 
    108 => "00000100", 109 => "11111111", 110 => "00000000", 111 => "00001001", 
    112 => "00010110", 113 => "00001011", 114 => "00000101", 115 => "11100101", 
    116 => "00000010", 117 => "11110011", 118 => "00000101", 119 => "00000101", 
    120 => "11101011", 121 => "11111000", 122 => "11100110", 123 => "00000010", 
    124 => "11101110", 125 => "00001001", 126 => "00000101", 127 => "00000011");



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

