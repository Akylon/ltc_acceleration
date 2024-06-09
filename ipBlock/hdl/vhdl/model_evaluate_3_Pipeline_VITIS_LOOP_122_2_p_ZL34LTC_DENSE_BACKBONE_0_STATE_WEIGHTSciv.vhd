-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSciv is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSciv is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "000000", 1 => "000000", 2 => "111111", 3 => "111111", 
    4 => "000000", 5 => "000001", 6 => "000001", 7 => "111111", 
    8 => "000000", 9 => "000000", 10 => "000000", 11 => "000001", 
    12 => "111101", 13 => "000100", 14 => "111010", 15 => "000000", 
    16 => "111111", 17 => "111111", 18 => "000000", 19 => "000010", 
    20 => "000001", 21 => "000000", 22 => "000001", 23 => "111110", 
    24 => "111111", 25 => "111110", 26 => "000001", 27 => "000010", 
    28 => "111110", 29 => "111111", 30 => "111100", 31 => "000010", 
    32 => "000000", 33 => "111111", 34 => "000000", 35 => "000010", 
    36 => "111101", 37 => "000010", 38 => "000001", 39 => "000001", 
    40 => "000000", 41 => "111111", 42 => "000011", 43 => "000100", 
    44 => "000001", 45 => "111101", 46 => "111101", 47 => "111110", 
    48 => "111101", 49 => "111111", 50 => "000010", 51 => "000011", 
    52 => "000000", 53 => "000100", 54 => "000101", 55 => "111110", 
    56 => "000111", 57 => "111111", 58 => "000101", 59 => "000000", 
    60 => "000010", 61 => "000010", 62 => "000010", 63 => "111101", 
    64 => "000011", 65 => "111110", 66 => "000101", 67 => "010011", 
    68 => "111001", 69 => "111010", 70 => "001000", 71 => "000011", 
    72 => "111100", 73 => "111110", 74 => "110101", 75 => "111001", 
    76 => "111101", 77 => "110010", 78 => "001101", 79 => "110111", 
    80 => "000100", 81 => "111110", 82 => "111100", 83 => "111100", 
    84 => "000001", 85 => "000000", 86 => "110111", 87 => "000100", 
    88 => "111100", 89 => "111100", 90 => "101100", 91 => "010001", 
    92 => "000111", 93 => "110001", 94 => "111011", 95 => "111101", 
    96 => "111111", 97 => "010001", 98 => "111011", 99 => "111010", 
    100 => "000101", 101 => "000010", 102 => "001000", 103 => "000101", 
    104 => "000000", 105 => "000101", 106 => "001101", 107 => "001000", 
    108 => "001011", 109 => "000110", 110 => "101111", 111 => "000101", 
    112 => "000011", 113 => "000100", 114 => "111110", 115 => "111010", 
    116 => "110111", 117 => "110111", 118 => "101001", 119 => "011001", 
    120 => "111001", 121 => "101010", 122 => "000110", 123 => "010010", 
    124 => "000001", 125 => "111101", 126 => "110111", 127 => "111100");



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

