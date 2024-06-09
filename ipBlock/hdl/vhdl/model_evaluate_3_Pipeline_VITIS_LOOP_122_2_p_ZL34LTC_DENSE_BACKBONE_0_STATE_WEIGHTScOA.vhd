-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScOA is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScOA is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "00100001", 1 => "00000000", 2 => "11110110", 3 => "11111111", 
    4 => "11110100", 5 => "11111111", 6 => "00000011", 7 => "11111100", 
    8 => "11000111", 9 => "00000000", 10 => "00000001", 11 => "11110010", 
    12 => "11101111", 13 => "00010010", 14 => "11101111", 15 => "00001011", 
    16 => "00011011", 17 => "11111111", 18 => "00000111", 19 => "11101011", 
    20 => "00001011", 21 => "11111001", 22 => "11101011", 23 => "11110000", 
    24 => "11101000", 25 => "11101100", 26 => "11100011", 27 => "11111000", 
    28 => "00101000", 29 => "11111011", 30 => "00010110", 31 => "00010010", 
    32 => "00001111", 33 => "00001001", 34 => "00000111", 35 => "11110100", 
    36 => "00001010", 37 => "11110101", 38 => "00000001", 39 => "11101001", 
    40 => "10111010", 41 => "00010000", 42 => "11111100", 43 => "00101000", 
    44 => "11011111", 45 => "11110100", 46 => "11101011", 47 => "11111011", 
    48 => "11111111", 49 => "00001000", 50 => "00000101", 51 => "00000111", 
    52 => "11100100", 53 => "00011010", 54 => "00001110", 55 => "11110010", 
    56 => "00000110", 57 => "11010110", 58 => "00010101", 59 => "00000000", 
    60 => "00001001", 61 => "11101100", 62 => "11110101", 63 => "00001011", 
    64 => "11110101", 65 => "00001010", 66 => "00001010", 67 => "00011001", 
    68 => "00000101", 69 => "11100101", 70 => "00010100", 71 => "11110111", 
    72 => "11111110", 73 => "00101000", 74 => "11110111", 75 => "11010110", 
    76 => "11110001", 77 => "00001001", 78 => "11001010", 79 => "00000111", 
    80 => "11110010", 81 => "00000000", 82 => "11111111", 83 => "11101001", 
    84 => "11101100", 85 => "00001001", 86 => "11110011", 87 => "11101101", 
    88 => "00000111", 89 => "11101010", 90 => "00011100", 91 => "11111010", 
    92 => "11101101", 93 => "00011111", 94 => "11110001", 95 => "00001111", 
    96 => "00000011", 97 => "00010001", 98 => "00010100", 99 => "11110000", 
    100 => "11111110", 101 => "00000010", 102 => "00011010", 103 => "00000101", 
    104 => "00001001", 105 => "00000011", 106 => "00010000", 107 => "00001110", 
    108 => "11110100", 109 => "11111001", 110 => "11111011", 111 => "00000101", 
    112 => "00001000", 113 => "00000100", 114 => "11111001", 115 => "00001010", 
    116 => "11101010", 117 => "00000000", 118 => "00110101", 119 => "11110100", 
    120 => "11100110", 121 => "11110100", 122 => "00001111", 123 => "11110101", 
    124 => "00000010", 125 => "00110000", 126 => "00011010", 127 => "00001101");



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
