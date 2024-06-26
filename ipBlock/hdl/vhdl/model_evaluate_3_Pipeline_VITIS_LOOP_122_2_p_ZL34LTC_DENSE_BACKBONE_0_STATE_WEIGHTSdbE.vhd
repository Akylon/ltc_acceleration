-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdbE is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdbE is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "0100001", 1 => "0001100", 2 => "0010001", 3 => "0010110", 
    4 => "1100010", 5 => "1101110", 6 => "1101110", 7 => "1101110", 
    8 => "0001010", 9 => "1000010", 10 => "1010011", 11 => "1111001", 
    12 => "1000111", 13 => "0001110", 14 => "0011101", 15 => "0011011", 
    16 => "0001000", 17 => "0010010", 18 => "0001111", 19 => "0000100", 
    20 => "1111100", 21 => "1111000", 22 => "1101000", 23 => "0000011", 
    24 => "0000011", 25 => "0011001", 26 => "0010000", 27 => "1100111", 
    28 => "1111001", 29 => "0001111", 30 => "0010011", 31 => "1011111", 
    32 => "0010010", 33 => "0110110", 34 => "0010001", 35 => "1111000", 
    36 => "0010101", 37 => "1010010", 38 => "1110001", 39 => "1111110", 
    40 => "1111000", 41 => "0110101", 42 => "0110000", 43 => "0000111", 
    44 => "1110101", 45 => "0001100", 46 => "1111101", 47 => "0010100", 
    48 => "0010111", 49 => "1010101", 50 => "1111011", 51 => "1111000", 
    52 => "0001001", 53 => "1110100", 54 => "0110011", 55 => "0000111", 
    56 => "1110110", 57 => "1100000", 58 => "0111010", 59 => "0010000", 
    60 => "1110010", 61 => "0001011", 62 => "0001010", 63 => "1111001", 
    64 => "0000111", 65 => "0001011", 66 => "1111011", 67 => "1110011", 
    68 => "0100000", 69 => "1110110", 70 => "1111111", 71 => "0010001", 
    72 => "1100101", 73 => "1101110", 74 => "1111000", 75 => "1110110", 
    76 => "1111010", 77 => "0000001", 78 => "0000110", 79 => "1101111", 
    80 => "1111111", 81 => "1111111", 82 => "0000000", 83 => "1111000", 
    84 => "0001000", 85 => "0001011", 86 => "1111100", 87 => "1111100", 
    88 => "1111100", 89 => "0000001", 90 => "0000000", 91 => "1111011", 
    92 => "0001000", 93 => "1101110", 94 => "1110011", 95 => "1101111", 
    96 => "0000101", 97 => "1111100", 98 => "1111001", 99 => "1110101", 
    100 => "1110010", 101 => "1111111", 102 => "0000001", 103 => "1111000", 
    104 => "1111100", 105 => "0000000", 106 => "0010000", 107 => "0000001", 
    108 => "1111100", 109 => "1111111", 110 => "1111001", 111 => "1110110", 
    112 => "1011010", 113 => "1111111", 114 => "0000110", 115 => "0000101", 
    116 => "1111000", 117 => "0001100", 118 => "0011001", 119 => "1111111", 
    120 => "1111101", 121 => "1111001", 122 => "1101110", 123 => "0001011", 
    124 => "1110011", 125 => "0000111", 126 => "0000100", 127 => "1110011");



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

