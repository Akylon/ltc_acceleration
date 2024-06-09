-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSddE is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSddE is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "0010010", 1 => "0000101", 2 => "1110001", 3 => "0001010", 
    4 => "1100111", 5 => "1111001", 6 => "0110111", 7 => "1110101", 
    8 => "1111111", 9 => "0001111", 10 => "0000010", 11 => "0001001", 
    12 => "0010000", 13 => "1111110", 14 => "0010011", 15 => "1100010", 
    16 => "0001011", 17 => "1110001", 18 => "1101001", 19 => "0100100", 
    20 => "1101110", 21 => "0011010", 22 => "0001001", 23 => "1111110", 
    24 => "1101101", 25 => "0000010", 26 => "1101110", 27 => "0000010", 
    28 => "0100100", 29 => "1100010", 30 => "0001011", 31 => "0000110", 
    32 => "1111010", 33 => "0000100", 34 => "1111001", 35 => "1100011", 
    36 => "1110111", 37 => "0000011", 38 => "1111101", 39 => "1101001", 
    40 => "0001001", 41 => "1110100", 42 => "0000001", 43 => "1110100", 
    44 => "0000000", 45 => "0010101", 46 => "0000000", 47 => "0001111", 
    48 => "1111010", 49 => "1110111", 50 => "0001100", 51 => "1010101", 
    52 => "1111010", 53 => "0011101", 54 => "0000011", 55 => "0010110", 
    56 => "1111110", 57 => "0010001", 58 => "0010100", 59 => "0000101", 
    60 => "0001001", 61 => "1101001", 62 => "0011101", 63 => "0000011", 
    64 => "0000101", 65 => "0000100", 66 => "0000001", 67 => "0001110", 
    68 => "1111011", 69 => "1111110", 70 => "0000101", 71 => "1111011", 
    72 => "0000111", 73 => "0000011", 74 => "0000001", 75 => "1111110", 
    76 => "1110100", 77 => "1111011", 78 => "1111001", 79 => "1111010", 
    80 => "1111101", 81 => "1110111", 82 => "1111110", 83 => "0000100", 
    84 => "0000000", 85 => "1111110", 86 => "0000001", 87 => "0000000", 
    88 => "0000101", 89 => "1111101", 90 => "0000011", 91 => "0000011", 
    92 => "1110110", 93 => "1111111", 94 => "0000110", 95 => "1111100", 
    96 => "1111100", 97 => "0001011", 98 => "1111100", 99 => "0000001", 
    100 => "1111000", 101 => "0000010", 102 => "0000000", 103 => "0000100", 
    104 => "0000010", 105 => "0000100", 106 => "1111100", 107 => "1111100", 
    108 => "0011100", 109 => "1111111", 110 => "0000100", 111 => "0000011", 
    112 => "1111101", 113 => "1111100", 114 => "1111001", 115 => "1101111", 
    116 => "0000110", 117 => "0000100", 118 => "1111001", 119 => "1111011", 
    120 => "0001000", 121 => "0001100", 122 => "1110100", 123 => "1111110", 
    124 => "1111010", 125 => "1111111", 126 => "1111011", 127 => "0000011");



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

