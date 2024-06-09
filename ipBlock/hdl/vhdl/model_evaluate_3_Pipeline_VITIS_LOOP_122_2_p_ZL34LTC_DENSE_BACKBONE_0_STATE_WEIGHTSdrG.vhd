-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdrG is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdrG is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "001010", 1 => "000001", 2 => "000111", 3 => "111100", 
    4 => "000110", 5 => "000111", 6 => "000000", 7 => "110100", 
    8 => "111010", 9 => "000010", 10 => "111001", 11 => "110010", 
    12 => "111110", 13 => "111110", 14 => "001001", 15 => "001101", 
    16 => "111111", 17 => "111100", 18 => "001011", 19 => "000011", 
    20 => "000001", 21 => "000101", 22 => "000010", 23 => "000001", 
    24 => "000011", 25 => "000010", 26 => "000010", 27 => "111000", 
    28 => "000110", 29 => "101111", 30 => "111000", 31 => "000110", 
    32 => "110101", 33 => "111100", 34 => "111110", 35 => "111001", 
    36 => "000100", 37 => "000110", 38 => "001010", 39 => "000111", 
    40 => "001011", 41 => "111100", 42 => "000111", 43 => "111001", 
    44 => "111111", 45 => "111111", 46 => "000111", 47 => "111100", 
    48 => "000111", 49 => "111001", 50 => "001101", 51 => "000010", 
    52 => "110000", 53 => "001010", 54 => "100101", 55 => "000110", 
    56 => "111101", 57 => "000010", 58 => "001100", 59 => "001000", 
    60 => "000111", 61 => "111100", 62 => "111010", 63 => "000010", 
    64 => "001000", 65 => "000110", 66 => "111001", 67 => "110001", 
    68 => "111010", 69 => "111100", 70 => "000100", 71 => "110000", 
    72 => "111101", 73 => "000001", 74 => "000011", 75 => "111001", 
    76 => "111111", 77 => "111011", 78 => "111000", 79 => "111010", 
    80 => "111100", 81 => "000001", 82 => "000010", 83 => "000000", 
    84 => "000000", 85 => "111001", 86 => "000111", 87 => "111101", 
    88 => "000100", 89 => "111001", 90 => "000100", 91 => "000111", 
    92 => "000100", 93 => "110100", 94 => "110001", 95 => "111011", 
    96 => "000011", 97 => "111000", 98 => "001000", 99 => "000011", 
    100 => "000100", 101 => "110010", 102 => "001000", 103 => "111001", 
    104 => "000011", 105 => "001001", 106 => "000000", 107 => "001001", 
    108 => "111101", 109 => "000000", 110 => "000010", 111 => "000011", 
    112 => "000100", 113 => "000111", 114 => "111110", 115 => "110001", 
    116 => "111011", 117 => "000111", 118 => "000001", 119 => "000101", 
    120 => "111100", 121 => "111100", 122 => "010111", 123 => "000010", 
    124 => "000001", 125 => "111110", 126 => "001111", 127 => "000001");



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

