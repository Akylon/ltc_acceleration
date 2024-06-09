-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSc2C is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSc2C is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1110110", 1 => "0000010", 2 => "1111010", 3 => "0000110", 
    4 => "1111100", 5 => "0000110", 6 => "0000010", 7 => "0001010", 
    8 => "0000111", 9 => "0001100", 10 => "0000010", 11 => "1111000", 
    12 => "0000100", 13 => "1111111", 14 => "0001111", 15 => "1111100", 
    16 => "0001100", 17 => "0001000", 18 => "1111000", 19 => "1111001", 
    20 => "0000001", 21 => "0001001", 22 => "1111110", 23 => "0000001", 
    24 => "1110111", 25 => "0000001", 26 => "1111011", 27 => "0001110", 
    28 => "0001000", 29 => "1110010", 30 => "0000010", 31 => "0000100", 
    32 => "0000011", 33 => "1111101", 34 => "1111110", 35 => "1111001", 
    36 => "0000010", 37 => "0001010", 38 => "1111111", 39 => "0000110", 
    40 => "0000011", 41 => "1111101", 42 => "0000010", 43 => "0000000", 
    44 => "0010001", 45 => "0000000", 46 => "1110111", 47 => "0000000", 
    48 => "0000001", 49 => "0000011", 50 => "1111011", 51 => "0001010", 
    52 => "0001000", 53 => "0000101", 54 => "1111110", 55 => "0001000", 
    56 => "1111111", 57 => "1111001", 58 => "0010000", 59 => "0000101", 
    60 => "0001000", 61 => "0000001", 62 => "1110101", 63 => "0000000", 
    64 => "0010111", 65 => "1110111", 66 => "0001111", 67 => "1111111", 
    68 => "1111110", 69 => "1110011", 70 => "0000010", 71 => "1111010", 
    72 => "0010101", 73 => "1101101", 74 => "0011000", 75 => "1111111", 
    76 => "1101111", 77 => "1110100", 78 => "1110111", 79 => "0000010", 
    80 => "0100111", 81 => "1110011", 82 => "1111111", 83 => "0001010", 
    84 => "1110110", 85 => "1111010", 86 => "1111110", 87 => "0011000", 
    88 => "0001101", 89 => "0010001", 90 => "0001000", 91 => "0000100", 
    92 => "0000100", 93 => "0010110", 94 => "0001100", 95 => "1110111", 
    96 => "0001100", 97 => "1111100", 98 => "0000010", 99 => "0011100", 
    100 => "0011101", 101 => "0000111", 102 => "1110011", 103 => "1111111", 
    104 => "0100100", 105 => "0010010", 106 => "1100111", 107 => "1101101", 
    108 => "1100011", 109 => "0000001", 110 => "1100011", 111 => "0000000", 
    112 => "1110001", 113 => "0011110", 114 => "0011000", 115 => "1100100", 
    116 => "1101100", 117 => "1101000", 118 => "1011001", 119 => "0010000", 
    120 => "1110111", 121 => "0000000", 122 => "1110101", 123 => "1100110", 
    124 => "0000111", 125 => "1111110", 126 => "0001101", 127 => "0001111");



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
