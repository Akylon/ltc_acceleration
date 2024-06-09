-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSckv is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSckv is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "000100", 1 => "111011", 2 => "111010", 3 => "000000", 
    4 => "000000", 5 => "111101", 6 => "000001", 7 => "000100", 
    8 => "111011", 9 => "000100", 10 => "000011", 11 => "110010", 
    12 => "000000", 13 => "000001", 14 => "000100", 15 => "111101", 
    16 => "000010", 17 => "111100", 18 => "000101", 19 => "111111", 
    20 => "110111", 21 => "111111", 22 => "111010", 23 => "111111", 
    24 => "111111", 25 => "111111", 26 => "111110", 27 => "110101", 
    28 => "000011", 29 => "000010", 30 => "000100", 31 => "111111", 
    32 => "111111", 33 => "000101", 34 => "000010", 35 => "111111", 
    36 => "000010", 37 => "000010", 38 => "000011", 39 => "000001", 
    40 => "001101", 41 => "000000", 42 => "000000", 43 => "000011", 
    44 => "000110", 45 => "000101", 46 => "000111", 47 => "000010", 
    48 => "111101", 49 => "000010", 50 => "001110", 51 => "111010", 
    52 => "110101", 53 => "000010", 54 => "000100", 55 => "100010", 
    56 => "111011", 57 => "111110", 58 => "000001", 59 => "000011", 
    60 => "111100", 61 => "000000", 62 => "111000", 63 => "000111", 
    64 => "000010", 65 => "111001", 66 => "000110", 67 => "000101", 
    68 => "101100", 69 => "110011", 70 => "111100", 71 => "001101", 
    72 => "100111", 73 => "001010", 74 => "111111", 75 => "110010", 
    76 => "111001", 77 => "110111", 78 => "001110", 79 => "001000", 
    80 => "000101", 81 => "000111", 82 => "111010", 83 => "100011", 
    84 => "000001", 85 => "001000", 86 => "110100", 87 => "111000", 
    88 => "000100", 89 => "001010", 90 => "000110", 91 => "001000", 
    92 => "111111", 93 => "110111", 94 => "111000", 95 => "110001", 
    96 => "111010", 97 => "111110", 98 => "111010", 99 => "000010", 
    100 => "011101", 101 => "001000", 102 => "000001", 103 => "000011", 
    104 => "001001", 105 => "111100", 106 => "101100", 107 => "001111", 
    108 => "000111", 109 => "000101", 110 => "110111", 111 => "111011", 
    112 => "111011", 113 => "110010", 114 => "001011", 115 => "100101", 
    116 => "000100", 117 => "111111", 118 => "000110", 119 => "000101", 
    120 => "000001", 121 => "101001", 122 => "001011", 123 => "001000", 
    124 => "110101", 125 => "110100", 126 => "101101", 127 => "000010");



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

