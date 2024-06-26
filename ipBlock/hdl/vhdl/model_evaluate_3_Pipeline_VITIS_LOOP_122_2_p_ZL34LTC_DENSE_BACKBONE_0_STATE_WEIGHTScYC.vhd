-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScYC is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScYC is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "11110011", 1 => "00000011", 2 => "11111101", 3 => "00001111", 
    4 => "11111010", 5 => "00000101", 6 => "11101111", 7 => "11111110", 
    8 => "11010111", 9 => "00000111", 10 => "00000100", 11 => "11110110", 
    12 => "00000010", 13 => "11111110", 14 => "11111001", 15 => "11111101", 
    16 => "00001101", 17 => "11111111", 18 => "00000010", 19 => "00001100", 
    20 => "00000110", 21 => "11111111", 22 => "11111000", 23 => "00000011", 
    24 => "11111100", 25 => "00000101", 26 => "00000001", 27 => "00010000", 
    28 => "11101101", 29 => "11111111", 30 => "11111010", 31 => "11011111", 
    32 => "00000010", 33 => "11100001", 34 => "00000010", 35 => "00000100", 
    36 => "11100000", 37 => "00001110", 38 => "00001000", 39 => "11111011", 
    40 => "00011011", 41 => "00000010", 42 => "00000100", 43 => "00010011", 
    44 => "11111101", 45 => "11111100", 46 => "11111100", 47 => "00000011", 
    48 => "00000000", 49 => "11010010", 50 => "11111101", 51 => "11100111", 
    52 => "11110010", 53 => "11101100", 54 => "00001100", 55 => "00001101", 
    56 => "11101100", 57 => "00000001", 58 => "00000010", 59 => "00100011", 
    60 => "11110111", 61 => "11111000", 62 => "11011101", 63 => "00001000", 
    64 => "11011100", 65 => "11100110", 66 => "00010101", 67 => "00001000", 
    68 => "00010011", 69 => "00001110", 70 => "11111101", 71 => "00000100", 
    72 => "00011100", 73 => "11111111", 74 => "11100001", 75 => "11101111", 
    76 => "00001011", 77 => "11110111", 78 => "11110101", 79 => "00100010", 
    80 => "00011110", 81 => "11101101", 82 => "00000011", 83 => "11001101", 
    84 => "11110100", 85 => "11100110", 86 => "11110101", 87 => "11110000", 
    88 => "11101101", 89 => "11110110", 90 => "11010111", 91 => "00010001", 
    92 => "11110000", 93 => "00010000", 94 => "00101110", 95 => "10111100", 
    96 => "11011101", 97 => "11101011", 98 => "11111110", 99 => "11100010", 
    100 => "11111110", 101 => "00101100", 102 => "11111010", 103 => "11101110", 
    104 => "00000011", 105 => "00000000", 106 => "11111100", 107 => "11110111", 
    108 => "11101010", 109 => "11111000", 110 => "11110101", 111 => "11110101", 
    112 => "00010011", 113 => "00010011", 114 => "00011011", 115 => "11110110", 
    116 => "11100110", 117 => "11100101", 118 => "11111000", 119 => "00010000", 
    120 => "11011110", 121 => "11110100", 122 => "00001100", 123 => "00100001", 
    124 => "11110111", 125 => "00101010", 126 => "11110101", 127 => "00011101");



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

