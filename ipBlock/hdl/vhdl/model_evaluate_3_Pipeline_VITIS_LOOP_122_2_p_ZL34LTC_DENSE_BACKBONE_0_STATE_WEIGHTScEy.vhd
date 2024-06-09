-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScEy is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScEy is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1110101", 1 => "1111100", 2 => "0000110", 3 => "1111011", 
    4 => "1111001", 5 => "1111000", 6 => "1111011", 7 => "1110110", 
    8 => "1101101", 9 => "1111001", 10 => "1111000", 11 => "1110011", 
    12 => "1110010", 13 => "0000011", 14 => "0010100", 15 => "1111000", 
    16 => "0000111", 17 => "0011111", 18 => "0000000", 19 => "1110111", 
    20 => "0000000", 21 => "0000000", 22 => "1111001", 23 => "0001000", 
    24 => "0000111", 25 => "1111000", 26 => "1111100", 27 => "1111111", 
    28 => "0001010", 29 => "0000111", 30 => "1111011", 31 => "1110110", 
    32 => "0001111", 33 => "0001101", 34 => "1111111", 35 => "1110001", 
    36 => "0000011", 37 => "1111010", 38 => "0001010", 39 => "0000000", 
    40 => "0001100", 41 => "1111000", 42 => "1111111", 43 => "1111110", 
    44 => "0000111", 45 => "0001001", 46 => "0000111", 47 => "1111110", 
    48 => "0001010", 49 => "0000101", 50 => "0001010", 51 => "0001000", 
    52 => "1110111", 53 => "1101111", 54 => "0000001", 55 => "0001000", 
    56 => "1110111", 57 => "1111001", 58 => "0010111", 59 => "0001011", 
    60 => "0000111", 61 => "1111101", 62 => "1101110", 63 => "0010100", 
    64 => "0010110", 65 => "1111011", 66 => "1110000", 67 => "1100110", 
    68 => "0001010", 69 => "1110100", 70 => "1110111", 71 => "1011101", 
    72 => "1100111", 73 => "0001110", 74 => "1101100", 75 => "1011111", 
    76 => "0011100", 77 => "1110011", 78 => "0001001", 79 => "1110100", 
    80 => "0011000", 81 => "0000000", 82 => "1011101", 83 => "1110110", 
    84 => "1101101", 85 => "0001011", 86 => "0000011", 87 => "1110001", 
    88 => "1011000", 89 => "1110001", 90 => "0000010", 91 => "0001000", 
    92 => "0011101", 93 => "0001100", 94 => "1110101", 95 => "1111101", 
    96 => "0010110", 97 => "0001000", 98 => "0011100", 99 => "1100010", 
    100 => "0001011", 101 => "1100110", 102 => "0000001", 103 => "1111110", 
    104 => "1111100", 105 => "1110001", 106 => "1101011", 107 => "1111000", 
    108 => "1100111", 109 => "0101100", 110 => "1010110", 111 => "0010011", 
    112 => "0101001", 113 => "0100000", 114 => "1111011", 115 => "1101001", 
    116 => "1110010", 117 => "1101100", 118 => "0001100", 119 => "0000100", 
    120 => "1100101", 121 => "1101100", 122 => "0100001", 123 => "1100001", 
    124 => "1100010", 125 => "0010010", 126 => "1000101", 127 => "0000000");



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

