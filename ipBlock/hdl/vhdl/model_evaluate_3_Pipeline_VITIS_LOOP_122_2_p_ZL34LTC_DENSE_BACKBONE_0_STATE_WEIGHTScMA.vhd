-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScMA is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScMA is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "0010100", 1 => "1110101", 2 => "1111110", 3 => "0001001", 
    4 => "1111110", 5 => "0011110", 6 => "1111000", 7 => "1110010", 
    8 => "0000111", 9 => "0010110", 10 => "1110011", 11 => "1101000", 
    12 => "1101110", 13 => "1111111", 14 => "0001101", 15 => "1101111", 
    16 => "1111110", 17 => "1111110", 18 => "0000100", 19 => "0001100", 
    20 => "0001111", 21 => "0010110", 22 => "0010000", 23 => "0000001", 
    24 => "0000011", 25 => "0000000", 26 => "1111010", 27 => "1110010", 
    28 => "0000010", 29 => "1101010", 30 => "0001000", 31 => "0001101", 
    32 => "0010101", 33 => "0011100", 34 => "1011100", 35 => "1101111", 
    36 => "0101000", 37 => "0000111", 38 => "1101101", 39 => "0011000", 
    40 => "0000000", 41 => "0000001", 42 => "0000010", 43 => "0000101", 
    44 => "0001001", 45 => "0000100", 46 => "1111100", 47 => "0010101", 
    48 => "0000100", 49 => "0011101", 50 => "0010010", 51 => "1010010", 
    52 => "1110001", 53 => "1111000", 54 => "1110101", 55 => "0011100", 
    56 => "1111011", 57 => "0001001", 58 => "0001110", 59 => "1110000", 
    60 => "1110011", 61 => "1110110", 62 => "1110100", 63 => "0001010", 
    64 => "1111100", 65 => "0100110", 66 => "0010110", 67 => "0000011", 
    68 => "0000010", 69 => "1111001", 70 => "0011010", 71 => "0011101", 
    72 => "0010011", 73 => "1101011", 74 => "1110011", 75 => "1101101", 
    76 => "0101011", 77 => "0001011", 78 => "0001000", 79 => "1111001", 
    80 => "1110111", 81 => "1100010", 82 => "1010111", 83 => "0000110", 
    84 => "0000010", 85 => "0001110", 86 => "0000101", 87 => "0001101", 
    88 => "0000011", 89 => "1110111", 90 => "0000001", 91 => "1110010", 
    92 => "0000101", 93 => "0001010", 94 => "1101111", 95 => "1111110", 
    96 => "1111111", 97 => "0010101", 98 => "1110100", 99 => "1110111", 
    100 => "1100110", 101 => "1111100", 102 => "1111001", 103 => "1100111", 
    104 => "0000100", 105 => "1111000", 106 => "0010000", 107 => "0000000", 
    108 => "1101011", 109 => "0001011", 110 => "0001001", 111 => "0000101", 
    112 => "1011000", 113 => "0010010", 114 => "0001101", 115 => "0000010", 
    116 => "1110011", 117 => "1111001", 118 => "0000100", 119 => "1100100", 
    120 => "1111011", 121 => "1101000", 122 => "0011001", 123 => "0000001", 
    124 => "0010000", 125 => "1111110", 126 => "0000101", 127 => "0000110");



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
