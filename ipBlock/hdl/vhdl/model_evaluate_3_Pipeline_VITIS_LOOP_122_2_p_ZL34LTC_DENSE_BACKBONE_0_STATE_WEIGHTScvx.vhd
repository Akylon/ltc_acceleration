-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScvx is 
    generic(
             DataWidth     : integer := 7; 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScvx is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1111111", 1 => "0001110", 2 => "1110010", 3 => "1110100", 
    4 => "0000111", 5 => "1111111", 6 => "0010000", 7 => "0000100", 
    8 => "0001010", 9 => "1111111", 10 => "1111001", 11 => "1110111", 
    12 => "1111100", 13 => "1110011", 14 => "1111100", 15 => "1110010", 
    16 => "1111010", 17 => "0010011", 18 => "1110000", 19 => "0000101", 
    20 => "0000001", 21 => "0001010", 22 => "0010000", 23 => "1101010", 
    24 => "1111100", 25 => "0000101", 26 => "1111100", 27 => "0010001", 
    28 => "0010001", 29 => "0000001", 30 => "0001101", 31 => "0000101", 
    32 => "1110001", 33 => "0001000", 34 => "0000110", 35 => "1111011", 
    36 => "0010101", 37 => "0001010", 38 => "1111110", 39 => "1110111", 
    40 => "0010010", 41 => "1111010", 42 => "0011101", 43 => "1111000", 
    44 => "0000001", 45 => "0000111", 46 => "1111000", 47 => "0000111", 
    48 => "1111101", 49 => "1110000", 50 => "0001000", 51 => "0010001", 
    52 => "0000010", 53 => "1101111", 54 => "1111000", 55 => "0000011", 
    56 => "1100011", 57 => "1100011", 58 => "0001101", 59 => "0000010", 
    60 => "0000100", 61 => "1111010", 62 => "0001001", 63 => "0011101", 
    64 => "0001010", 65 => "0000000", 66 => "1011011", 67 => "0001001", 
    68 => "1111111", 69 => "0000111", 70 => "1111100", 71 => "0001000", 
    72 => "1101000", 73 => "0000001", 74 => "1111001", 75 => "1110101", 
    76 => "1101010", 77 => "1111110", 78 => "0001110", 79 => "1110101", 
    80 => "0000001", 81 => "0010000", 82 => "0000000", 83 => "1110000", 
    84 => "0010111", 85 => "1111011", 86 => "1111000", 87 => "0000001", 
    88 => "1110011", 89 => "0000100", 90 => "1111011", 91 => "0001101", 
    92 => "1110100", 93 => "0001010", 94 => "0000101", 95 => "1110000", 
    96 => "0001100", 97 => "1110100", 98 => "0001010", 99 => "0000110", 
    100 => "0100000", 101 => "1110000", 102 => "1111100", 103 => "1111010", 
    104 => "1111111", 105 => "0001100", 106 => "1101111", 107 => "0000100", 
    108 => "0101001", 109 => "0010000", 110 => "0000000", 111 => "1110111", 
    112 => "0110100", 113 => "1110100", 114 => "0010111", 115 => "1111010", 
    116 => "1111000", 117 => "0000111", 118 => "0001001", 119 => "0000011", 
    120 => "1011000", 121 => "1110001", 122 => "0010101", 123 => "0001100", 
    124 => "1100111", 125 => "1111111", 126 => "1110000", 127 => "1111110");



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
