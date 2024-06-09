-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdmF is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdmF is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1110101", 1 => "0011000", 2 => "0000100", 3 => "1111100", 
    4 => "0000110", 5 => "0000100", 6 => "0010011", 7 => "1110100", 
    8 => "0010001", 9 => "1111000", 10 => "0001001", 11 => "1101101", 
    12 => "1111101", 13 => "1111000", 14 => "1110111", 15 => "1101010", 
    16 => "1110111", 17 => "1110101", 18 => "1110110", 19 => "1100110", 
    20 => "0001000", 21 => "0001001", 22 => "1111111", 23 => "1110111", 
    24 => "0000100", 25 => "1111000", 26 => "0001010", 27 => "0001110", 
    28 => "0000111", 29 => "1101011", 30 => "1110001", 31 => "0000110", 
    32 => "0000111", 33 => "1111110", 34 => "0000110", 35 => "1111110", 
    36 => "1111000", 37 => "1111000", 38 => "1111011", 39 => "1110100", 
    40 => "0100001", 41 => "0000111", 42 => "0100000", 43 => "1111111", 
    44 => "0001011", 45 => "0001010", 46 => "1101001", 47 => "0000000", 
    48 => "1110101", 49 => "0010111", 50 => "0001001", 51 => "0001111", 
    52 => "1101111", 53 => "0001000", 54 => "1110110", 55 => "0011100", 
    56 => "1110101", 57 => "1100110", 58 => "0110100", 59 => "1101111", 
    60 => "0001001", 61 => "1111111", 62 => "0000100", 63 => "1111100", 
    64 => "1111111", 65 => "0000111", 66 => "0010101", 67 => "1111110", 
    68 => "1101011", 69 => "1100000", 70 => "0001010", 71 => "1111001", 
    72 => "0001000", 73 => "1101010", 74 => "0010000", 75 => "1101001", 
    76 => "0000000", 77 => "1111100", 78 => "0010110", 79 => "1010101", 
    80 => "0001001", 81 => "1100110", 82 => "1011110", 83 => "1111101", 
    84 => "0000111", 85 => "1111011", 86 => "0000101", 87 => "0001011", 
    88 => "1111000", 89 => "0010100", 90 => "1111111", 91 => "0000101", 
    92 => "0001101", 93 => "0000000", 94 => "1011111", 95 => "0001100", 
    96 => "1111110", 97 => "1111111", 98 => "1101000", 99 => "1110111", 
    100 => "1111100", 101 => "1100111", 102 => "1100001", 103 => "1100010", 
    104 => "0001111", 105 => "0010101", 106 => "0001010", 107 => "1111100", 
    108 => "1111011", 109 => "0000011", 110 => "1110111", 111 => "1010101", 
    112 => "1101101", 113 => "1100001", 114 => "0000100", 115 => "0001100", 
    116 => "0001011", 117 => "1111000", 118 => "0001000", 119 => "1110001", 
    120 => "0001100", 121 => "0100111", 122 => "0101001", 123 => "0001001", 
    124 => "0000111", 125 => "1110100", 126 => "1110111", 127 => "0001101");



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
