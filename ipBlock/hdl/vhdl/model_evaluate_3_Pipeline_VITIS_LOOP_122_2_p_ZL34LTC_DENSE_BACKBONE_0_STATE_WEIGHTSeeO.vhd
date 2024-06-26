-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSeeO is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSeeO is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1110110", 1 => "0001100", 2 => "0000010", 3 => "0000011", 
    4 => "1110110", 5 => "0001101", 6 => "1110110", 7 => "0000001", 
    8 => "1111110", 9 => "1111010", 10 => "1111101", 11 => "1110111", 
    12 => "0010000", 13 => "1111101", 14 => "1111000", 15 => "0001011", 
    16 => "1111010", 17 => "1110111", 18 => "0001000", 19 => "1111000", 
    20 => "1111011", 21 => "0000001", 22 => "0000111", 23 => "0001001", 
    24 => "0000001", 25 => "1101100", 26 => "0001001", 27 => "0000110", 
    28 => "1110110", 29 => "1110110", 30 => "1111110", 31 => "0001110", 
    32 => "0000100", 33 => "0000010", 34 => "1111110", 35 => "1111111", 
    36 => "1111000", 37 => "0000000", 38 => "1111100", 39 => "0000111", 
    40 => "0001000", 41 => "0001001", 42 => "0001001", 43 => "1111111", 
    44 => "0010110", 45 => "1110101", 46 => "0000010", 47 => "0000001", 
    48 => "0001101", 49 => "1111011", 50 => "0000001", 51 => "1111101", 
    52 => "1110000", 53 => "0001001", 54 => "1111111", 55 => "0000110", 
    56 => "0001100", 57 => "1110110", 58 => "1111101", 59 => "1110111", 
    60 => "1110001", 61 => "1111011", 62 => "0000000", 63 => "1110001", 
    64 => "0000100", 65 => "0001100", 66 => "1111110", 67 => "0000000", 
    68 => "1110010", 69 => "1101000", 70 => "1110100", 71 => "1111010", 
    72 => "1101011", 73 => "0000110", 74 => "0000000", 75 => "1101101", 
    76 => "0000100", 77 => "1111101", 78 => "1111001", 79 => "0000001", 
    80 => "1111110", 81 => "0010001", 82 => "1110010", 83 => "1100110", 
    84 => "0001100", 85 => "0001101", 86 => "1110111", 87 => "0000000", 
    88 => "0000110", 89 => "0000001", 90 => "0000111", 91 => "1110111", 
    92 => "0011010", 93 => "1110001", 94 => "0000100", 95 => "1110110", 
    96 => "1101000", 97 => "1111001", 98 => "0000001", 99 => "0010111", 
    100 => "0001111", 101 => "0000111", 102 => "0000101", 103 => "1111011", 
    104 => "1110111", 105 => "0011010", 106 => "1111011", 107 => "0010000", 
    108 => "0010001", 109 => "0001000", 110 => "0001000", 111 => "1110010", 
    112 => "0010111", 113 => "0010001", 114 => "1111000", 115 => "1111011", 
    116 => "0000011", 117 => "1110100", 118 => "0010100", 119 => "1111001", 
    120 => "1100000", 121 => "1011010", 122 => "0100000", 123 => "0000111", 
    124 => "1111010", 125 => "0001010", 126 => "1110000", 127 => "0011001");



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

