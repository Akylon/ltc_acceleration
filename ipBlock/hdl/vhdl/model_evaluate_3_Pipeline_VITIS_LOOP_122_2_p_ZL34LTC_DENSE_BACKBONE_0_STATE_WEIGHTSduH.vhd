-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSduH is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSduH is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "0010000", 1 => "0001000", 2 => "1100001", 3 => "1111110", 
    4 => "1111001", 5 => "1110111", 6 => "1110011", 7 => "0000010", 
    8 => "1110011", 9 => "1110111", 10 => "1111101", 11 => "1001101", 
    12 => "1011100", 13 => "1101101", 14 => "1110101", 15 => "0001001", 
    16 => "1100011", 17 => "0000010", 18 => "1110100", 19 => "1111101", 
    20 => "0010000", 21 => "0010110", 22 => "0011001", 23 => "0000101", 
    24 => "0000000", 25 => "0000101", 26 => "1111101", 27 => "1101101", 
    28 => "1111000", 29 => "0010010", 30 => "0000111", 31 => "0000001", 
    32 => "0000100", 33 => "0010111", 34 => "1111011", 35 => "0000000", 
    36 => "0000001", 37 => "0000111", 38 => "0000001", 39 => "1111000", 
    40 => "0010000", 41 => "0011100", 42 => "1101011", 43 => "1111110", 
    44 => "1101100", 45 => "0010010", 46 => "1111000", 47 => "1110000", 
    48 => "0100000", 49 => "0000100", 50 => "1110110", 51 => "0000000", 
    52 => "1101010", 53 => "1111110", 54 => "0010100", 55 => "0000011", 
    56 => "1101011", 57 => "0001110", 58 => "0010001", 59 => "0010010", 
    60 => "1101000", 61 => "0001011", 62 => "1110100", 63 => "1111001", 
    64 => "1111110", 65 => "1111110", 66 => "0000100", 67 => "0000000", 
    68 => "1110010", 69 => "1111011", 70 => "1111110", 71 => "1111010", 
    72 => "0000011", 73 => "0000111", 74 => "1110011", 75 => "1101100", 
    76 => "0000100", 77 => "1111100", 78 => "1111001", 79 => "1110101", 
    80 => "0000000", 81 => "0000001", 82 => "0000011", 83 => "1111000", 
    84 => "0000111", 85 => "0000100", 86 => "0000011", 87 => "0000011", 
    88 => "1111001", 89 => "1111100", 90 => "0000010", 91 => "0000100", 
    92 => "1101001", 93 => "1110010", 94 => "0001010", 95 => "1111000", 
    96 => "0000110", 97 => "0000100", 98 => "1110111", 99 => "1111010", 
    100 => "0001010", 101 => "1111101", 102 => "1111010", 103 => "0000100", 
    104 => "0001001", 105 => "0010011", 106 => "1111001", 107 => "0000111", 
    108 => "1111001", 109 => "0001000", 110 => "0001001", 111 => "0000010", 
    112 => "1111001", 113 => "1111010", 114 => "1111111", 115 => "1100100", 
    116 => "0001110", 117 => "0001010", 118 => "0000000", 119 => "0001001", 
    120 => "1101101", 121 => "1111010", 122 => "0000100", 123 => "1111100", 
    124 => "1101111", 125 => "1111111", 126 => "1111111", 127 => "0000001");



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

