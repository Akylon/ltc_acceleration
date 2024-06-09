-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSd5N is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSd5N is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "000110", 1 => "000100", 2 => "110110", 3 => "110100", 
    4 => "111111", 5 => "111111", 6 => "000011", 7 => "000101", 
    8 => "000001", 9 => "111001", 10 => "000111", 11 => "111000", 
    12 => "001100", 13 => "111111", 14 => "000010", 15 => "111101", 
    16 => "001000", 17 => "110101", 18 => "000000", 19 => "101111", 
    20 => "110001", 21 => "000000", 22 => "111110", 23 => "111010", 
    24 => "111111", 25 => "111101", 26 => "111110", 27 => "110110", 
    28 => "001000", 29 => "000000", 30 => "110110", 31 => "111010", 
    32 => "000111", 33 => "001000", 34 => "001010", 35 => "111110", 
    36 => "111111", 37 => "001000", 38 => "001100", 39 => "000001", 
    40 => "001110", 41 => "000011", 42 => "000010", 43 => "000000", 
    44 => "001001", 45 => "000110", 46 => "000001", 47 => "000011", 
    48 => "000100", 49 => "111110", 50 => "111100", 51 => "100101", 
    52 => "001001", 53 => "001010", 54 => "001001", 55 => "001111", 
    56 => "111011", 57 => "110111", 58 => "001100", 59 => "000000", 
    60 => "000001", 61 => "111110", 62 => "001000", 63 => "111111", 
    64 => "000000", 65 => "000001", 66 => "111101", 67 => "110111", 
    68 => "001011", 69 => "001001", 70 => "111011", 71 => "000000", 
    72 => "111001", 73 => "111000", 74 => "001001", 75 => "110011", 
    76 => "111111", 77 => "110001", 78 => "001100", 79 => "001010", 
    80 => "000010", 81 => "000100", 82 => "111101", 83 => "001000", 
    84 => "001101", 85 => "001000", 86 => "111101", 87 => "110100", 
    88 => "000111", 89 => "000010", 90 => "111110", 91 => "001100", 
    92 => "000111", 93 => "110001", 94 => "000100", 95 => "110100", 
    96 => "111010", 97 => "001100", 98 => "000011", 99 => "111100", 
    100 => "001111", 101 => "111111", 102 => "000110", 103 => "000101", 
    104 => "000101", 105 => "001001", 106 => "000111", 107 => "111101", 
    108 => "011010", 109 => "001010", 110 => "000010", 111 => "000111", 
    112 => "000011", 113 => "000110", 114 => "110101", 115 => "111001", 
    116 => "000110", 117 => "101100", 118 => "001011", 119 => "011111", 
    120 => "100101", 121 => "101100", 122 => "011010", 123 => "001000", 
    124 => "111000", 125 => "111111", 126 => "111011", 127 => "001111");



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

