-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdHJ is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdHJ is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "0000111", 1 => "0000100", 2 => "1110100", 3 => "0000100", 
    4 => "1100100", 5 => "0001101", 6 => "0000100", 7 => "0000111", 
    8 => "1111000", 9 => "0000011", 10 => "1111001", 11 => "1101000", 
    12 => "1110011", 13 => "1101001", 14 => "0000001", 15 => "0000010", 
    16 => "1111110", 17 => "1111110", 18 => "0000010", 19 => "1110011", 
    20 => "1110010", 21 => "0001011", 22 => "1111111", 23 => "1111101", 
    24 => "1101111", 25 => "0001110", 26 => "1111000", 27 => "1111110", 
    28 => "0000110", 29 => "1011111", 30 => "1101111", 31 => "1101011", 
    32 => "0001001", 33 => "0011101", 34 => "1111000", 35 => "1110100", 
    36 => "0000011", 37 => "1111110", 38 => "0010000", 39 => "0000001", 
    40 => "1110011", 41 => "1111010", 42 => "0001100", 43 => "0010101", 
    44 => "0000000", 45 => "1111101", 46 => "1111000", 47 => "1110011", 
    48 => "0011101", 49 => "1110001", 50 => "0001110", 51 => "1111011", 
    52 => "1111011", 53 => "0001100", 54 => "0000011", 55 => "0000100", 
    56 => "0010011", 57 => "1111000", 58 => "1111000", 59 => "0000000", 
    60 => "1111010", 61 => "1111110", 62 => "0000010", 63 => "1111000", 
    64 => "1100011", 65 => "1110111", 66 => "0000100", 67 => "1011111", 
    68 => "1111011", 69 => "0010110", 70 => "0000110", 71 => "1101111", 
    72 => "0001010", 73 => "1111110", 74 => "0100000", 75 => "1101011", 
    76 => "1110001", 77 => "0010111", 78 => "0000111", 79 => "0000000", 
    80 => "0001000", 81 => "1111100", 82 => "1101100", 83 => "1110010", 
    84 => "0000111", 85 => "1111001", 86 => "0010011", 87 => "0000011", 
    88 => "0001000", 89 => "1010101", 90 => "0010010", 91 => "0011011", 
    92 => "1111101", 93 => "0010111", 94 => "0011011", 95 => "1101100", 
    96 => "1100010", 97 => "1110001", 98 => "1110010", 99 => "0001000", 
    100 => "0010100", 101 => "1101111", 102 => "0011010", 103 => "0000111", 
    104 => "0001100", 105 => "0010001", 106 => "0000101", 107 => "0011001", 
    108 => "0010100", 109 => "1110010", 110 => "1011110", 111 => "0001111", 
    112 => "1111000", 113 => "0000111", 114 => "0010111", 115 => "1110011", 
    116 => "0001101", 117 => "1010101", 118 => "0100111", 119 => "0000100", 
    120 => "0000001", 121 => "1110110", 122 => "0100100", 123 => "0011000", 
    124 => "1101011", 125 => "1110011", 126 => "0010100", 127 => "1110110");



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
