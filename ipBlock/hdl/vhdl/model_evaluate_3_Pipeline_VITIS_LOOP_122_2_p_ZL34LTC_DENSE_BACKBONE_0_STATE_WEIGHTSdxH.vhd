-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdxH is 
    generic(
             DataWidth     : integer := 8; 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdxH is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "11011000", 1 => "00100111", 2 => "11100000", 3 => "11110111", 
    4 => "00001101", 5 => "11100111", 6 => "00001010", 7 => "00001110", 
    8 => "11010111", 9 => "00010000", 10 => "11110010", 11 => "00000101", 
    12 => "11011100", 13 => "00011010", 14 => "00011001", 15 => "00010010", 
    16 => "00011010", 17 => "11110001", 18 => "11110001", 19 => "00000101", 
    20 => "11011111", 21 => "11111110", 22 => "11011111", 23 => "00011010", 
    24 => "00000101", 25 => "11011001", 26 => "11111110", 27 => "11111101", 
    28 => "00001100", 29 => "00001011", 30 => "00011101", 31 => "11110001", 
    32 => "00010101", 33 => "11110000", 34 => "00011110", 35 => "11111011", 
    36 => "00000000", 37 => "00001001", 38 => "00001010", 39 => "00000101", 
    40 => "11101110", 41 => "00011111", 42 => "00000110", 43 => "11101101", 
    44 => "11111011", 45 => "00010000", 46 => "00100010", 47 => "11110000", 
    48 => "00010110", 49 => "00011010", 50 => "11100100", 51 => "11111110", 
    52 => "11011000", 53 => "11111011", 54 => "00000100", 55 => "11011110", 
    56 => "11111001", 57 => "11101111", 58 => "00000010", 59 => "00010100", 
    60 => "11110001", 61 => "11111011", 62 => "11011001", 63 => "00100000", 
    64 => "00100100", 65 => "00001011", 66 => "11111001", 67 => "11101001", 
    68 => "11111011", 69 => "00010101", 70 => "00001101", 71 => "00100111", 
    72 => "00001010", 73 => "00000001", 74 => "00000001", 75 => "11100101", 
    76 => "00001000", 77 => "11111010", 78 => "11111001", 79 => "00010101", 
    80 => "00011001", 81 => "11110100", 82 => "00000111", 83 => "11111110", 
    84 => "11100001", 85 => "00001000", 86 => "11110111", 87 => "00010011", 
    88 => "11110000", 89 => "00000111", 90 => "11111000", 91 => "11111101", 
    92 => "00001010", 93 => "11111000", 94 => "00010110", 95 => "00000101", 
    96 => "11110010", 97 => "00000111", 98 => "00100001", 99 => "11110110", 
    100 => "00010110", 101 => "00001011", 102 => "00000001", 103 => "00000011", 
    104 => "00000001", 105 => "11110100", 106 => "00001110", 107 => "00000011", 
    108 => "00000001", 109 => "00001011", 110 => "11111010", 111 => "11111110", 
    112 => "00101000", 113 => "00011011", 114 => "11101111", 115 => "11101100", 
    116 => "11100101", 117 => "00000101", 118 => "00010001", 119 => "11110000", 
    120 => "11101111", 121 => "11101110", 122 => "01000010", 123 => "00010100", 
    124 => "00000100", 125 => "00001011", 126 => "00010101", 127 => "00001001");



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

