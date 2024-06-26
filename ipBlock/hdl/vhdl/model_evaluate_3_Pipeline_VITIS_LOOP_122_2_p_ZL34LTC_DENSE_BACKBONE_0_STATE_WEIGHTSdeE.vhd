-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdeE is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdeE is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1111010", 1 => "1111111", 2 => "0000001", 3 => "0000010", 
    4 => "0000100", 5 => "0000110", 6 => "0000101", 7 => "0000101", 
    8 => "0000110", 9 => "1111101", 10 => "1111011", 11 => "1111011", 
    12 => "0001011", 13 => "0000001", 14 => "0000111", 15 => "0000100", 
    16 => "1110110", 17 => "0000101", 18 => "0000110", 19 => "1111100", 
    20 => "0000101", 21 => "0001110", 22 => "1110011", 23 => "1111100", 
    24 => "0000000", 25 => "1110111", 26 => "0001000", 27 => "0000001", 
    28 => "1110011", 29 => "1111010", 30 => "1110011", 31 => "1110101", 
    32 => "1111101", 33 => "1111000", 34 => "1110101", 35 => "0000001", 
    36 => "1111100", 37 => "0000110", 38 => "1111101", 39 => "0000111", 
    40 => "0001010", 41 => "0000101", 42 => "1111100", 43 => "0001010", 
    44 => "0000100", 45 => "0000011", 46 => "1111100", 47 => "0000000", 
    48 => "0011010", 49 => "0000001", 50 => "1111111", 51 => "1110100", 
    52 => "0000001", 53 => "1111000", 54 => "0000100", 55 => "0000001", 
    56 => "1110101", 57 => "1110011", 58 => "0100100", 59 => "0000111", 
    60 => "1110100", 61 => "0000010", 62 => "0000111", 63 => "0000011", 
    64 => "0000011", 65 => "1111101", 66 => "1110100", 67 => "1101101", 
    68 => "0001011", 69 => "1101111", 70 => "0000011", 71 => "1111111", 
    72 => "0000010", 73 => "1110010", 74 => "1110110", 75 => "0000101", 
    76 => "1110111", 77 => "1111100", 78 => "1011111", 79 => "1011110", 
    80 => "0001011", 81 => "1011110", 82 => "1011101", 83 => "1110101", 
    84 => "1110000", 85 => "0010001", 86 => "0001001", 87 => "0000011", 
    88 => "0001111", 89 => "1111000", 90 => "1010110", 91 => "1101111", 
    92 => "1110000", 93 => "1111011", 94 => "0011011", 95 => "1111001", 
    96 => "1110111", 97 => "0000010", 98 => "1111110", 99 => "1111111", 
    100 => "1101111", 101 => "1111110", 102 => "0001001", 103 => "1110110", 
    104 => "0001011", 105 => "0000101", 106 => "0000000", 107 => "0001110", 
    108 => "0001001", 109 => "0000011", 110 => "1100111", 111 => "0001000", 
    112 => "1110101", 113 => "0010011", 114 => "1111100", 115 => "1111011", 
    116 => "0011100", 117 => "0000010", 118 => "0001111", 119 => "0000101", 
    120 => "0000010", 121 => "0010010", 122 => "0010101", 123 => "0001000", 
    124 => "1111100", 125 => "0001100", 126 => "0000101", 127 => "1101101");



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

