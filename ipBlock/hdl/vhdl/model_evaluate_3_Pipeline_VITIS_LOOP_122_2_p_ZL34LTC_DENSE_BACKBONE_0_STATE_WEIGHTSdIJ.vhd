-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdIJ is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdIJ is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "111001", 1 => "110011", 2 => "001010", 3 => "001001", 
    4 => "111100", 5 => "111110", 6 => "111001", 7 => "111000", 
    8 => "110110", 9 => "111001", 10 => "000000", 11 => "000000", 
    12 => "110111", 13 => "111100", 14 => "000010", 15 => "000011", 
    16 => "111100", 17 => "000011", 18 => "000000", 19 => "000010", 
    20 => "001000", 21 => "000001", 22 => "111111", 23 => "000000", 
    24 => "111100", 25 => "000001", 26 => "000010", 27 => "001000", 
    28 => "000101", 29 => "111011", 30 => "001011", 31 => "111001", 
    32 => "111110", 33 => "110011", 34 => "000111", 35 => "111010", 
    36 => "000010", 37 => "000011", 38 => "111010", 39 => "000011", 
    40 => "001000", 41 => "001000", 42 => "111111", 43 => "000011", 
    44 => "111001", 45 => "000010", 46 => "000001", 47 => "000000", 
    48 => "111110", 49 => "001001", 50 => "001001", 51 => "111001", 
    52 => "111101", 53 => "111100", 54 => "110101", 55 => "111010", 
    56 => "111111", 57 => "111010", 58 => "000000", 59 => "111000", 
    60 => "111011", 61 => "000011", 62 => "000001", 63 => "000001", 
    64 => "000011", 65 => "000101", 66 => "000101", 67 => "000000", 
    68 => "111010", 69 => "111111", 70 => "000011", 71 => "111110", 
    72 => "111010", 73 => "000000", 74 => "001000", 75 => "111010", 
    76 => "000111", 77 => "000110", 78 => "101101", 79 => "000110", 
    80 => "111101", 81 => "111010", 82 => "111110", 83 => "111111", 
    84 => "110100", 85 => "111011", 86 => "111110", 87 => "000001", 
    88 => "000011", 89 => "000101", 90 => "000110", 91 => "111100", 
    92 => "111100", 93 => "010000", 94 => "111101", 95 => "111101", 
    96 => "000010", 97 => "000001", 98 => "000000", 99 => "000011", 
    100 => "000101", 101 => "111011", 102 => "000011", 103 => "000000", 
    104 => "111100", 105 => "111100", 106 => "111111", 107 => "111110", 
    108 => "111011", 109 => "111101", 110 => "000110", 111 => "000001", 
    112 => "111111", 113 => "111001", 114 => "111111", 115 => "110000", 
    116 => "110011", 117 => "111100", 118 => "111101", 119 => "111001", 
    120 => "000000", 121 => "111101", 122 => "011100", 123 => "111011", 
    124 => "111001", 125 => "000000", 126 => "111111", 127 => "111111");



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

