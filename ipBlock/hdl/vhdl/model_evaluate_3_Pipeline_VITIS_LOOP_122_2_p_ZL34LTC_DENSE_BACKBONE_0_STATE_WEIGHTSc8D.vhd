-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSc8D is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSc8D is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1111111", 1 => "0001001", 2 => "1110011", 3 => "1111001", 
    4 => "1111110", 5 => "1111111", 6 => "0000101", 7 => "0000110", 
    8 => "0001001", 9 => "1111000", 10 => "1111001", 11 => "1111100", 
    12 => "0010110", 13 => "1111011", 14 => "1110000", 15 => "0001111", 
    16 => "0000001", 17 => "0000011", 18 => "1111000", 19 => "1110111", 
    20 => "0000001", 21 => "0010110", 22 => "0000110", 23 => "0000011", 
    24 => "0011010", 25 => "0000100", 26 => "0001000", 27 => "1111010", 
    28 => "0011000", 29 => "1110010", 30 => "0000001", 31 => "1110010", 
    32 => "0000010", 33 => "1111011", 34 => "0010001", 35 => "0000000", 
    36 => "1111010", 37 => "0000011", 38 => "1111001", 39 => "1111011", 
    40 => "1111110", 41 => "0010000", 42 => "0010100", 43 => "1111010", 
    44 => "0000011", 45 => "1111101", 46 => "1111001", 47 => "0000000", 
    48 => "0001010", 49 => "0000011", 50 => "1111001", 51 => "0000011", 
    52 => "1111100", 53 => "0010000", 54 => "0010010", 55 => "0011010", 
    56 => "1101010", 57 => "0000111", 58 => "0100011", 59 => "1111110", 
    60 => "1111010", 61 => "1111111", 62 => "0011010", 63 => "1111011", 
    64 => "1111000", 65 => "1111100", 66 => "0010110", 67 => "1110010", 
    68 => "1111000", 69 => "0000010", 70 => "0100000", 71 => "0000000", 
    72 => "0000110", 73 => "0011010", 74 => "1110001", 75 => "0000011", 
    76 => "0001101", 77 => "1111101", 78 => "0001010", 79 => "1111101", 
    80 => "0000001", 81 => "1100001", 82 => "1110110", 83 => "0001100", 
    84 => "1101011", 85 => "0000001", 86 => "1110011", 87 => "0000111", 
    88 => "1110110", 89 => "0001001", 90 => "1111001", 91 => "0000011", 
    92 => "0000001", 93 => "0000001", 94 => "0001000", 95 => "0000000", 
    96 => "1111110", 97 => "1111001", 98 => "0000001", 99 => "1100110", 
    100 => "1111100", 101 => "0000111", 102 => "0010011", 103 => "0010001", 
    104 => "0101011", 105 => "1101100", 106 => "0101000", 107 => "1101011", 
    108 => "0011000", 109 => "1111010", 110 => "1101001", 111 => "1111111", 
    112 => "0011100", 113 => "0000111", 114 => "0010001", 115 => "0010001", 
    116 => "0011001", 117 => "1110110", 118 => "0010011", 119 => "1111011", 
    120 => "1111001", 121 => "1110011", 122 => "1111110", 123 => "0001000", 
    124 => "0000010", 125 => "0000000", 126 => "0011100", 127 => "0000000");



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
