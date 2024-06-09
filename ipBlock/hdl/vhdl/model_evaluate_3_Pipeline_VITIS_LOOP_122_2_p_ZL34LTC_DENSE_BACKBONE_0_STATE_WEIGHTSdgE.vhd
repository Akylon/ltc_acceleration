-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdgE is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdgE is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1100111", 1 => "0001111", 2 => "1110110", 3 => "0010100", 
    4 => "0001011", 5 => "0000110", 6 => "0000001", 7 => "0011111", 
    8 => "1111010", 9 => "1101001", 10 => "1111101", 11 => "1111000", 
    12 => "0001001", 13 => "0001111", 14 => "0001100", 15 => "0011000", 
    16 => "0001110", 17 => "1110101", 18 => "1010100", 19 => "1110011", 
    20 => "0011000", 21 => "1110010", 22 => "1111100", 23 => "0001111", 
    24 => "0001110", 25 => "0000100", 26 => "1111110", 27 => "0000001", 
    28 => "0000101", 29 => "0000010", 30 => "0000100", 31 => "1101101", 
    32 => "0000101", 33 => "0001001", 34 => "1110001", 35 => "1100000", 
    36 => "0101110", 37 => "0000000", 38 => "1111000", 39 => "1110000", 
    40 => "1110110", 41 => "0010010", 42 => "0010101", 43 => "0000101", 
    44 => "0010001", 45 => "1111101", 46 => "1110000", 47 => "1111110", 
    48 => "0011101", 49 => "1110000", 50 => "1111000", 51 => "0010100", 
    52 => "1110001", 53 => "1111000", 54 => "0011000", 55 => "0100110", 
    56 => "0010000", 57 => "1111110", 58 => "0001001", 59 => "0000010", 
    60 => "1011011", 61 => "0000100", 62 => "1110000", 63 => "1110011", 
    64 => "0000100", 65 => "0001011", 66 => "0001011", 67 => "1111011", 
    68 => "1010000", 69 => "1101001", 70 => "0010101", 71 => "1110000", 
    72 => "0100100", 73 => "0011101", 74 => "1101111", 75 => "1000111", 
    76 => "1000110", 77 => "1110100", 78 => "0010000", 79 => "0000111", 
    80 => "1110011", 81 => "1111000", 82 => "0010001", 83 => "0000010", 
    84 => "0011001", 85 => "1101111", 86 => "1101001", 87 => "0010001", 
    88 => "0000010", 89 => "0010111", 90 => "0000101", 91 => "0011100", 
    92 => "1111101", 93 => "0011100", 94 => "0010110", 95 => "1101110", 
    96 => "0000100", 97 => "1111000", 98 => "0001101", 99 => "1110110", 
    100 => "0001001", 101 => "0000011", 102 => "1111100", 103 => "1110111", 
    104 => "1101100", 105 => "0010100", 106 => "0010100", 107 => "0001010", 
    108 => "0011000", 109 => "1111011", 110 => "1110101", 111 => "0010011", 
    112 => "0101000", 113 => "0011001", 114 => "0001011", 115 => "1101100", 
    116 => "0001010", 117 => "1110000", 118 => "0001011", 119 => "0010100", 
    120 => "1101110", 121 => "1111001", 122 => "0001101", 123 => "1111011", 
    124 => "1111101", 125 => "1110001", 126 => "1111011", 127 => "1111110");



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

