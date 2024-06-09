-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSd8N is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSd8N is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "000001", 1 => "110111", 2 => "111001", 3 => "010111", 
    4 => "010100", 5 => "001100", 6 => "111110", 7 => "000111", 
    8 => "000001", 9 => "110011", 10 => "111110", 11 => "101011", 
    12 => "101110", 13 => "111111", 14 => "110110", 15 => "000100", 
    16 => "111110", 17 => "000101", 18 => "010010", 19 => "000001", 
    20 => "000110", 21 => "110001", 22 => "110010", 23 => "111001", 
    24 => "110100", 25 => "111110", 26 => "110111", 27 => "000001", 
    28 => "011100", 29 => "001000", 30 => "110010", 31 => "111100", 
    32 => "001000", 33 => "001100", 34 => "010001", 35 => "000100", 
    36 => "001100", 37 => "111111", 38 => "010101", 39 => "000000", 
    40 => "111110", 41 => "110111", 42 => "001101", 43 => "000001", 
    44 => "001010", 45 => "110001", 46 => "110110", 47 => "111100", 
    48 => "010111", 49 => "001001", 50 => "111000", 51 => "100001", 
    52 => "001011", 53 => "000110", 54 => "111000", 55 => "011100", 
    56 => "000001", 57 => "000001", 58 => "011101", 59 => "000010", 
    60 => "110100", 61 => "111111", 62 => "001001", 63 => "111011", 
    64 => "000100", 65 => "111111", 66 => "000011", 67 => "111010", 
    68 => "110111", 69 => "111111", 70 => "000001", 71 => "000101", 
    72 => "111111", 73 => "000101", 74 => "000001", 75 => "111110", 
    76 => "000000", 77 => "110101", 78 => "000100", 79 => "111111", 
    80 => "000011", 81 => "001101", 82 => "111011", 83 => "111001", 
    84 => "000100", 85 => "000111", 86 => "000100", 87 => "000011", 
    88 => "000001", 89 => "001010", 90 => "000011", 91 => "000100", 
    92 => "001100", 93 => "111001", 94 => "000001", 95 => "000000", 
    96 => "111110", 97 => "111000", 98 => "000100", 99 => "111111", 
    100 => "000011", 101 => "001010", 102 => "110100", 103 => "001000", 
    104 => "000000", 105 => "000000", 106 => "101111", 107 => "111011", 
    108 => "110001", 109 => "000011", 110 => "000000", 111 => "111101", 
    112 => "111010", 113 => "111100", 114 => "111111", 115 => "011001", 
    116 => "010010", 117 => "000001", 118 => "111010", 119 => "010011", 
    120 => "100111", 121 => "110101", 122 => "110011", 123 => "111100", 
    124 => "000110", 125 => "000001", 126 => "000011", 127 => "111111");



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

