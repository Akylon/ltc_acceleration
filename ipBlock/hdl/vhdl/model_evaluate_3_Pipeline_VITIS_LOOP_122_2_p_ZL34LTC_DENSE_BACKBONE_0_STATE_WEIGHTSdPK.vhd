-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdPK is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdPK is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "00000010", 1 => "00010100", 2 => "11111000", 3 => "11011011", 
    4 => "00001100", 5 => "00000011", 6 => "11111101", 7 => "11111000", 
    8 => "11110101", 9 => "11101010", 10 => "00000100", 11 => "11110010", 
    12 => "11110110", 13 => "11110000", 14 => "00000011", 15 => "00010000", 
    16 => "00000000", 17 => "00000000", 18 => "11111001", 19 => "00000001", 
    20 => "00000110", 21 => "00001011", 22 => "00000000", 23 => "11111101", 
    24 => "11111110", 25 => "00000000", 26 => "00000011", 27 => "11111011", 
    28 => "00000001", 29 => "11111111", 30 => "11110001", 31 => "11110011", 
    32 => "11111110", 33 => "11111100", 34 => "00000011", 35 => "11110101", 
    36 => "00001010", 37 => "00001010", 38 => "00000111", 39 => "11111110", 
    40 => "00001111", 41 => "00001000", 42 => "00000100", 43 => "00000000", 
    44 => "00010100", 45 => "11110101", 46 => "00000100", 47 => "00000001", 
    48 => "11111101", 49 => "00000110", 50 => "11110111", 51 => "11101001", 
    52 => "00000110", 53 => "11101111", 54 => "11111101", 55 => "00000101", 
    56 => "11110011", 57 => "11111001", 58 => "00010011", 59 => "00001001", 
    60 => "00000101", 61 => "11110111", 62 => "11111010", 63 => "00000011", 
    64 => "00101110", 65 => "00011110", 66 => "11111011", 67 => "00000010", 
    68 => "00011100", 69 => "11110000", 70 => "11010100", 71 => "11110001", 
    72 => "10111000", 73 => "11100001", 74 => "00001000", 75 => "10111001", 
    76 => "01010000", 77 => "00100110", 78 => "11001000", 79 => "11110010", 
    80 => "00001000", 81 => "00100101", 82 => "00010011", 83 => "11010101", 
    84 => "11111000", 85 => "00000001", 86 => "11110110", 87 => "00000100", 
    88 => "11101101", 89 => "00011110", 90 => "00101100", 91 => "11110011", 
    92 => "11111101", 93 => "11110000", 94 => "11101101", 95 => "11010010", 
    96 => "11110010", 97 => "01000010", 98 => "11101100", 99 => "11100110", 
    100 => "00010111", 101 => "11110001", 102 => "11101001", 103 => "11101011", 
    104 => "00000101", 105 => "00001111", 106 => "11011111", 107 => "00100000", 
    108 => "11110000", 109 => "11100101", 110 => "11111011", 111 => "11111110", 
    112 => "11111110", 113 => "11011101", 114 => "00010100", 115 => "00000111", 
    116 => "11000101", 117 => "00111110", 118 => "00110000", 119 => "00101111", 
    120 => "11111100", 121 => "11010101", 122 => "00010111", 123 => "11110000", 
    124 => "11100001", 125 => "00101110", 126 => "00101000", 127 => "11111110");



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

