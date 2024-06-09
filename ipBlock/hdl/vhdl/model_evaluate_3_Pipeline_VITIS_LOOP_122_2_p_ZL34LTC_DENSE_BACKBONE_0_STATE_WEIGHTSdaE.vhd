-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdaE is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdaE is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1110100", 1 => "0000010", 2 => "0000011", 3 => "0000000", 
    4 => "1100101", 5 => "1110011", 6 => "0001111", 7 => "1111000", 
    8 => "0000101", 9 => "1111110", 10 => "0010110", 11 => "1101011", 
    12 => "1101101", 13 => "1100101", 14 => "0101000", 15 => "0010111", 
    16 => "0000110", 17 => "0010001", 18 => "0000111", 19 => "1100010", 
    20 => "1110111", 21 => "1110110", 22 => "1101110", 23 => "0011000", 
    24 => "1110111", 25 => "1100101", 26 => "1111001", 27 => "1101100", 
    28 => "1110001", 29 => "0000100", 30 => "1110111", 31 => "0001001", 
    32 => "0001000", 33 => "1110010", 34 => "0001101", 35 => "1111001", 
    36 => "0010100", 37 => "0011100", 38 => "0001100", 39 => "0010001", 
    40 => "1011011", 41 => "0001110", 42 => "0101011", 43 => "1111011", 
    44 => "1110011", 45 => "0010110", 46 => "0000000", 47 => "0001101", 
    48 => "1100110", 49 => "0010001", 50 => "1111001", 51 => "1111000", 
    52 => "0000010", 53 => "1111100", 54 => "0000111", 55 => "0001000", 
    56 => "1010111", 57 => "1011111", 58 => "0000000", 59 => "0000000", 
    60 => "1111010", 61 => "1111011", 62 => "1101111", 63 => "0000110", 
    64 => "1111001", 65 => "1101111", 66 => "1111011", 67 => "1110111", 
    68 => "0000000", 69 => "0000010", 70 => "0010101", 71 => "0000011", 
    72 => "0000010", 73 => "0000110", 74 => "1101100", 75 => "1100011", 
    76 => "1111110", 77 => "0110011", 78 => "1110010", 79 => "1111100", 
    80 => "0100010", 81 => "0001111", 82 => "0000010", 83 => "1110011", 
    84 => "1101111", 85 => "1111011", 86 => "1101001", 87 => "1110110", 
    88 => "1110000", 89 => "1110110", 90 => "1111111", 91 => "0000111", 
    92 => "0100100", 93 => "1111011", 94 => "0000101", 95 => "0001001", 
    96 => "0000100", 97 => "0001111", 98 => "1111110", 99 => "0001101", 
    100 => "0011001", 101 => "0011010", 102 => "0000010", 103 => "0000001", 
    104 => "0001011", 105 => "0011100", 106 => "0010111", 107 => "1101101", 
    108 => "1100000", 109 => "0000111", 110 => "0001011", 111 => "0001110", 
    112 => "1111010", 113 => "0010010", 114 => "1111011", 115 => "1110111", 
    116 => "0001010", 117 => "0000011", 118 => "1101111", 119 => "1100010", 
    120 => "0001000", 121 => "1110010", 122 => "1110010", 123 => "1101011", 
    124 => "1101111", 125 => "0000100", 126 => "1110010", 127 => "1110110");



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
