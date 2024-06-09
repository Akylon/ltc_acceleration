-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdGJ is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdGJ is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "0000010", 1 => "0000010", 2 => "0000001", 3 => "1111000", 
    4 => "0000000", 5 => "0000000", 6 => "0000011", 7 => "1111001", 
    8 => "1111001", 9 => "0000000", 10 => "1111100", 11 => "1110101", 
    12 => "1110111", 13 => "1111110", 14 => "0010100", 15 => "0000100", 
    16 => "0000000", 17 => "0000100", 18 => "1110010", 19 => "1110110", 
    20 => "0000011", 21 => "0000100", 22 => "0000011", 23 => "1111001", 
    24 => "0001101", 25 => "0001000", 26 => "1111110", 27 => "1111110", 
    28 => "0001111", 29 => "1111110", 30 => "1111010", 31 => "1111010", 
    32 => "0000001", 33 => "0000110", 34 => "0000010", 35 => "1110100", 
    36 => "0001011", 37 => "1111011", 38 => "1111110", 39 => "1111110", 
    40 => "1111101", 41 => "0000001", 42 => "0000000", 43 => "0000011", 
    44 => "0000000", 45 => "1111011", 46 => "1111101", 47 => "1111010", 
    48 => "0001110", 49 => "0000010", 50 => "0000101", 51 => "1111010", 
    52 => "0001001", 53 => "0000001", 54 => "0010001", 55 => "0001010", 
    56 => "1111010", 57 => "1101000", 58 => "0010011", 59 => "0000000", 
    60 => "1110111", 61 => "1111101", 62 => "0000010", 63 => "0000001", 
    64 => "1111101", 65 => "1110100", 66 => "0000010", 67 => "0001110", 
    68 => "1101100", 69 => "1110111", 70 => "0001000", 71 => "1111000", 
    72 => "1111001", 73 => "1101111", 74 => "1110011", 75 => "1111000", 
    76 => "1100100", 77 => "0000010", 78 => "1111100", 79 => "1100010", 
    80 => "1111010", 81 => "0000000", 82 => "1110111", 83 => "1100111", 
    84 => "1110001", 85 => "1110110", 86 => "0000100", 87 => "0000000", 
    88 => "1101101", 89 => "0000000", 90 => "1111100", 91 => "0000110", 
    92 => "0011000", 93 => "1111000", 94 => "0000101", 95 => "1110100", 
    96 => "0000000", 97 => "0011111", 98 => "1011011", 99 => "1110010", 
    100 => "1110100", 101 => "0000011", 102 => "0101011", 103 => "1110011", 
    104 => "1110110", 105 => "1111100", 106 => "1111110", 107 => "0001001", 
    108 => "0101110", 109 => "0001101", 110 => "1111110", 111 => "0000110", 
    112 => "0001011", 113 => "0000010", 114 => "1111010", 115 => "1000011", 
    116 => "1101101", 117 => "1100110", 118 => "1111011", 119 => "0000101", 
    120 => "1100000", 121 => "1011011", 122 => "0010100", 123 => "0000111", 
    124 => "1111110", 125 => "0001111", 126 => "0001110", 127 => "1111000");



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
