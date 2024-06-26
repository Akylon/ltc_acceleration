-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScVB is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScVB is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1101101", 1 => "0000101", 2 => "0001111", 3 => "0000001", 
    4 => "1110101", 5 => "0001111", 6 => "1110111", 7 => "1111110", 
    8 => "0001100", 9 => "1110101", 10 => "0001000", 11 => "0000100", 
    12 => "1101111", 13 => "1111100", 14 => "0000101", 15 => "1100100", 
    16 => "0000011", 17 => "1111110", 18 => "0000111", 19 => "1111001", 
    20 => "1111101", 21 => "0000000", 22 => "0000010", 23 => "1110000", 
    24 => "0000010", 25 => "1101011", 26 => "0010001", 27 => "0000111", 
    28 => "0001000", 29 => "0010110", 30 => "0011111", 31 => "1100011", 
    32 => "0000110", 33 => "0001111", 34 => "0000110", 35 => "1111100", 
    36 => "1101010", 37 => "1111100", 38 => "1110100", 39 => "1101100", 
    40 => "0000010", 41 => "0011110", 42 => "1110101", 43 => "1111100", 
    44 => "1111010", 45 => "0001010", 46 => "1111011", 47 => "0000001", 
    48 => "0011110", 49 => "1110111", 50 => "0000100", 51 => "1111000", 
    52 => "1101100", 53 => "1111111", 54 => "1110111", 55 => "1110100", 
    56 => "0000010", 57 => "1110000", 58 => "0010101", 59 => "1110110", 
    60 => "0000011", 61 => "1110010", 62 => "0101010", 63 => "0010100", 
    64 => "0000010", 65 => "0001000", 66 => "0000010", 67 => "1111011", 
    68 => "0000000", 69 => "0000000", 70 => "0000101", 71 => "1110100", 
    72 => "1111010", 73 => "0000110", 74 => "1110101", 75 => "1101100", 
    76 => "1110010", 77 => "1111010", 78 => "0001010", 79 => "0000100", 
    80 => "0000101", 81 => "0010000", 82 => "1100001", 83 => "1101001", 
    84 => "0010111", 85 => "0000001", 86 => "0000011", 87 => "0000110", 
    88 => "0000111", 89 => "1110110", 90 => "0001001", 91 => "0001010", 
    92 => "0010001", 93 => "1111111", 94 => "1111000", 95 => "0001010", 
    96 => "1110111", 97 => "0010110", 98 => "0001000", 99 => "1111111", 
    100 => "0000110", 101 => "0000110", 102 => "1111010", 103 => "1111000", 
    104 => "0011000", 105 => "0000000", 106 => "1111100", 107 => "0001101", 
    108 => "1101011", 109 => "0000100", 110 => "0000100", 111 => "0000011", 
    112 => "1110110", 113 => "0001001", 114 => "1111011", 115 => "1011011", 
    116 => "1111000", 117 => "1110100", 118 => "0001011", 119 => "1111001", 
    120 => "1100011", 121 => "1001100", 122 => "0001100", 123 => "1110000", 
    124 => "0000101", 125 => "0000000", 126 => "1111101", 127 => "1111101");



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

