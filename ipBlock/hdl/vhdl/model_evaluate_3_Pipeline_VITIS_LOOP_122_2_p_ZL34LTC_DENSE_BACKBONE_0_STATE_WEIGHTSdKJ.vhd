-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdKJ is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdKJ is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1111010", 1 => "0000111", 2 => "1111011", 3 => "1110010", 
    4 => "0001110", 5 => "0000000", 6 => "1111100", 7 => "1111010", 
    8 => "0001011", 9 => "0000111", 10 => "1110010", 11 => "1110000", 
    12 => "1110001", 13 => "0000100", 14 => "0000010", 15 => "1110101", 
    16 => "0000110", 17 => "0000101", 18 => "1110111", 19 => "0000101", 
    20 => "0001010", 21 => "0000011", 22 => "0000011", 23 => "1111110", 
    24 => "0001001", 25 => "1111001", 26 => "1111101", 27 => "0011011", 
    28 => "0000111", 29 => "1111011", 30 => "0001101", 31 => "0000010", 
    32 => "0000010", 33 => "0010001", 34 => "0000110", 35 => "1110010", 
    36 => "1111110", 37 => "1111110", 38 => "0001001", 39 => "1111110", 
    40 => "0000001", 41 => "0000100", 42 => "0000110", 43 => "0010001", 
    44 => "0000110", 45 => "0000000", 46 => "1111110", 47 => "0000111", 
    48 => "1110111", 49 => "0010010", 50 => "1110111", 51 => "1100111", 
    52 => "1111100", 53 => "1100100", 54 => "1100100", 55 => "0001100", 
    56 => "1101111", 57 => "1110011", 58 => "1110011", 59 => "0000010", 
    60 => "1110100", 61 => "0000001", 62 => "1111101", 63 => "0001000", 
    64 => "0000001", 65 => "0100011", 66 => "1110101", 67 => "1110010", 
    68 => "0010010", 69 => "0001001", 70 => "1111110", 71 => "0000001", 
    72 => "1110011", 73 => "1111011", 74 => "0000110", 75 => "1101011", 
    76 => "0001100", 77 => "1101011", 78 => "0001101", 79 => "0000100", 
    80 => "0000000", 81 => "0000111", 82 => "0001101", 83 => "0000000", 
    84 => "1111111", 85 => "0001111", 86 => "1111111", 87 => "1111000", 
    88 => "0000111", 89 => "0010110", 90 => "1111000", 91 => "1111110", 
    92 => "0010011", 93 => "1110010", 94 => "1101110", 95 => "1100011", 
    96 => "1110110", 97 => "0010101", 98 => "0000010", 99 => "1111110", 
    100 => "1111011", 101 => "1111111", 102 => "0000111", 103 => "1111010", 
    104 => "1101101", 105 => "0000110", 106 => "1111011", 107 => "1101111", 
    108 => "0000001", 109 => "1111110", 110 => "1111111", 111 => "0001000", 
    112 => "0011011", 113 => "0011001", 114 => "1110001", 115 => "1110101", 
    116 => "0000100", 117 => "1110000", 118 => "1111111", 119 => "1110111", 
    120 => "1110110", 121 => "1101111", 122 => "0010101", 123 => "1111111", 
    124 => "1111111", 125 => "1110010", 126 => "0001011", 127 => "1110101");



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

