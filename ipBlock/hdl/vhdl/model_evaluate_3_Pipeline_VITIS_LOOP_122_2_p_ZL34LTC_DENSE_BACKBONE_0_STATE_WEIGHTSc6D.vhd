-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSc6D is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSc6D is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "111110", 1 => "111111", 2 => "110111", 3 => "111110", 
    4 => "111010", 5 => "010010", 6 => "110111", 7 => "000010", 
    8 => "110111", 9 => "000110", 10 => "000000", 11 => "110010", 
    12 => "001111", 13 => "110000", 14 => "111010", 15 => "000111", 
    16 => "111000", 17 => "000011", 18 => "101001", 19 => "110001", 
    20 => "110110", 21 => "000100", 22 => "001011", 23 => "111010", 
    24 => "111010", 25 => "110110", 26 => "000001", 27 => "110101", 
    28 => "110011", 29 => "110010", 30 => "111010", 31 => "000010", 
    32 => "111111", 33 => "110100", 34 => "000001", 35 => "110110", 
    36 => "001100", 37 => "111011", 38 => "000111", 39 => "111001", 
    40 => "001010", 41 => "001011", 42 => "000011", 43 => "111000", 
    44 => "111100", 45 => "000001", 46 => "111010", 47 => "111110", 
    48 => "010101", 49 => "001010", 50 => "111001", 51 => "110000", 
    52 => "000010", 53 => "010110", 54 => "000000", 55 => "011000", 
    56 => "001110", 57 => "110100", 58 => "001101", 59 => "111000", 
    60 => "111011", 61 => "110110", 62 => "000101", 63 => "000011", 
    64 => "000011", 65 => "000110", 66 => "111101", 67 => "111101", 
    68 => "001000", 69 => "111000", 70 => "111111", 71 => "111111", 
    72 => "000100", 73 => "111011", 74 => "001010", 75 => "111101", 
    76 => "001100", 77 => "111100", 78 => "110111", 79 => "111111", 
    80 => "000001", 81 => "110000", 82 => "110110", 83 => "111011", 
    84 => "101011", 85 => "111111", 86 => "000111", 87 => "000000", 
    88 => "000100", 89 => "000100", 90 => "000000", 91 => "000000", 
    92 => "000111", 93 => "111111", 94 => "000110", 95 => "111001", 
    96 => "111100", 97 => "111000", 98 => "111101", 99 => "111000", 
    100 => "111101", 101 => "000011", 102 => "111101", 103 => "111111", 
    104 => "111001", 105 => "110111", 106 => "001000", 107 => "111111", 
    108 => "110110", 109 => "111101", 110 => "000010", 111 => "001010", 
    112 => "101011", 113 => "111100", 114 => "000101", 115 => "000100", 
    116 => "111110", 117 => "101110", 118 => "111110", 119 => "111011", 
    120 => "111111", 121 => "111111", 122 => "000010", 123 => "000111", 
    124 => "000000", 125 => "111110", 126 => "000110", 127 => "000010");



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

