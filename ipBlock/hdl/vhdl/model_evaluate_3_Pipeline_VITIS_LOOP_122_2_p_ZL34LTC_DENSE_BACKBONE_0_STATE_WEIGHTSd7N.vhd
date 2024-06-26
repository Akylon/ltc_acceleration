-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSd7N is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSd7N is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1001110", 1 => "0011010", 2 => "1110111", 3 => "1100001", 
    4 => "1111101", 5 => "1111100", 6 => "0011111", 7 => "1111111", 
    8 => "0011101", 9 => "1110011", 10 => "1110101", 11 => "1000111", 
    12 => "1000111", 13 => "0000101", 14 => "1111110", 15 => "1111101", 
    16 => "0011010", 17 => "0011100", 18 => "1100000", 19 => "0001111", 
    20 => "1111100", 21 => "0001110", 22 => "1111001", 23 => "0100100", 
    24 => "1111011", 25 => "0000011", 26 => "1110100", 27 => "1001110", 
    28 => "0011011", 29 => "0001110", 30 => "0001001", 31 => "1011010", 
    32 => "1110110", 33 => "0100010", 34 => "0000011", 35 => "0011111", 
    36 => "1111001", 37 => "0001111", 38 => "1111010", 39 => "1110100", 
    40 => "0100111", 41 => "0011010", 42 => "1110001", 43 => "0101000", 
    44 => "0010111", 45 => "1011111", 46 => "0001010", 47 => "1110001", 
    48 => "1101111", 49 => "1101111", 50 => "1110110", 51 => "0011011", 
    52 => "1111011", 53 => "1111100", 54 => "0101001", 55 => "1001100", 
    56 => "1000110", 57 => "0000000", 58 => "0011111", 59 => "0101001", 
    60 => "0001101", 61 => "1110100", 62 => "1100000", 63 => "1110000", 
    64 => "0001011", 65 => "0001001", 66 => "0000101", 67 => "1110010", 
    68 => "0000110", 69 => "1111101", 70 => "1110011", 71 => "1111101", 
    72 => "0000100", 73 => "1111010", 74 => "0000001", 75 => "1110110", 
    76 => "0001111", 77 => "1111111", 78 => "1110101", 79 => "1111110", 
    80 => "1111101", 81 => "0000110", 82 => "0000011", 83 => "1111000", 
    84 => "0000011", 85 => "0000010", 86 => "0000010", 87 => "1111111", 
    88 => "0000100", 89 => "1111110", 90 => "0000010", 91 => "0000000", 
    92 => "0000110", 93 => "0001010", 94 => "0000110", 95 => "1111111", 
    96 => "1111110", 97 => "1110110", 98 => "1111010", 99 => "0001010", 
    100 => "1110100", 101 => "1111001", 102 => "1111001", 103 => "0000110", 
    104 => "1111100", 105 => "1111110", 106 => "1110110", 107 => "0001111", 
    108 => "0011001", 109 => "1111001", 110 => "0000101", 111 => "0000001", 
    112 => "0000101", 113 => "0000100", 114 => "1111100", 115 => "1111011", 
    116 => "1101100", 117 => "1110001", 118 => "1101111", 119 => "1111000", 
    120 => "0000111", 121 => "0000001", 122 => "0010111", 123 => "0001001", 
    124 => "0000000", 125 => "1111101", 126 => "1110001", 127 => "0000000");



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

