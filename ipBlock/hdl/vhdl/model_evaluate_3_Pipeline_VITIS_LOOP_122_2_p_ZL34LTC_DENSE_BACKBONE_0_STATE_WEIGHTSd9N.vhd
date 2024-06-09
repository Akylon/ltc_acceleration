-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSd9N is 
    generic(
             DataWidth     : integer := 6; 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSd9N is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "111110", 1 => "111000", 2 => "000100", 3 => "001001", 
    4 => "111110", 5 => "111010", 6 => "001000", 7 => "111110", 
    8 => "111111", 9 => "110111", 10 => "000011", 11 => "111110", 
    12 => "000000", 13 => "001011", 14 => "110111", 15 => "001001", 
    16 => "101111", 17 => "000001", 18 => "000001", 19 => "110011", 
    20 => "111001", 21 => "110010", 22 => "111101", 23 => "001011", 
    24 => "001000", 25 => "000110", 26 => "111010", 27 => "010000", 
    28 => "110001", 29 => "000100", 30 => "111001", 31 => "000111", 
    32 => "000101", 33 => "000111", 34 => "000111", 35 => "101100", 
    36 => "001010", 37 => "111111", 38 => "000000", 39 => "000100", 
    40 => "001011", 41 => "111111", 42 => "110111", 43 => "000110", 
    44 => "111001", 45 => "000100", 46 => "000010", 47 => "111101", 
    48 => "101001", 49 => "111100", 50 => "001101", 51 => "110000", 
    52 => "000011", 53 => "111001", 54 => "110101", 55 => "110010", 
    56 => "111001", 57 => "110010", 58 => "000000", 59 => "001111", 
    60 => "110010", 61 => "001110", 62 => "000001", 63 => "110111", 
    64 => "000010", 65 => "001010", 66 => "111101", 67 => "000100", 
    68 => "000000", 69 => "000000", 70 => "111101", 71 => "111010", 
    72 => "111011", 73 => "000001", 74 => "111011", 75 => "101110", 
    76 => "110110", 77 => "000011", 78 => "000100", 79 => "111110", 
    80 => "000000", 81 => "110110", 82 => "110001", 83 => "111010", 
    84 => "000111", 85 => "000101", 86 => "111100", 87 => "001001", 
    88 => "000111", 89 => "000110", 90 => "111111", 91 => "111111", 
    92 => "111011", 93 => "110100", 94 => "111110", 95 => "000101", 
    96 => "000001", 97 => "001110", 98 => "000111", 99 => "101111", 
    100 => "111111", 101 => "000111", 102 => "000010", 103 => "111111", 
    104 => "000100", 105 => "111110", 106 => "000111", 107 => "000010", 
    108 => "001100", 109 => "000001", 110 => "000010", 111 => "000010", 
    112 => "010011", 113 => "000000", 114 => "000110", 115 => "111001", 
    116 => "111011", 117 => "111000", 118 => "001000", 119 => "111011", 
    120 => "101100", 121 => "110001", 122 => "001101", 123 => "111001", 
    124 => "110111", 125 => "111110", 126 => "000000", 127 => "000101");



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

