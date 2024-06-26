-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScJz is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScJz is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "0010001", 1 => "0000000", 2 => "0001110", 3 => "1101010", 
    4 => "0000111", 5 => "1111001", 6 => "0001000", 7 => "1111110", 
    8 => "1111010", 9 => "0000101", 10 => "1111101", 11 => "1100010", 
    12 => "0000011", 13 => "1111000", 14 => "1111010", 15 => "0001110", 
    16 => "1111010", 17 => "0000001", 18 => "0001000", 19 => "0000010", 
    20 => "0010101", 21 => "0001001", 22 => "1110111", 23 => "1110110", 
    24 => "1110011", 25 => "1111101", 26 => "0001100", 27 => "0001001", 
    28 => "1111101", 29 => "1110001", 30 => "0001110", 31 => "0000100", 
    32 => "1111001", 33 => "0001001", 34 => "0001000", 35 => "1111100", 
    36 => "0001010", 37 => "1110011", 38 => "1111111", 39 => "0000010", 
    40 => "1111011", 41 => "0001000", 42 => "1111000", 43 => "0000101", 
    44 => "1100100", 45 => "0000100", 46 => "0000000", 47 => "0000000", 
    48 => "0100111", 49 => "0010000", 50 => "1111110", 51 => "1110110", 
    52 => "0000100", 53 => "1111000", 54 => "0000001", 55 => "0000100", 
    56 => "1100100", 57 => "0000000", 58 => "0000000", 59 => "0001000", 
    60 => "1110110", 61 => "1111110", 62 => "1110000", 63 => "0000000", 
    64 => "1111011", 65 => "1101110", 66 => "0001001", 67 => "1110110", 
    68 => "1110111", 69 => "0000011", 70 => "1111010", 71 => "0000010", 
    72 => "1111011", 73 => "0001010", 74 => "1111010", 75 => "1100101", 
    76 => "1110001", 77 => "1111001", 78 => "1111101", 79 => "0010101", 
    80 => "1111001", 81 => "1111011", 82 => "1110110", 83 => "1101110", 
    84 => "1111001", 85 => "0001010", 86 => "1101100", 87 => "0000101", 
    88 => "0001010", 89 => "1110101", 90 => "0001010", 91 => "0000011", 
    92 => "1111101", 93 => "1110111", 94 => "0001100", 95 => "1111010", 
    96 => "1111011", 97 => "0010110", 98 => "1111101", 99 => "0001010", 
    100 => "0010110", 101 => "1111100", 102 => "1111001", 103 => "0000011", 
    104 => "0000110", 105 => "1110001", 106 => "0001100", 107 => "0000010", 
    108 => "1111100", 109 => "0000100", 110 => "1111101", 111 => "0000010", 
    112 => "0010110", 113 => "1110110", 114 => "0001010", 115 => "1100110", 
    116 => "0010100", 117 => "0000000", 118 => "0010010", 119 => "0000100", 
    120 => "1101100", 121 => "1100101", 122 => "1111101", 123 => "1111001", 
    124 => "1110000", 125 => "0001000", 126 => "1110000", 127 => "0001001");



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

