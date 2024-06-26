-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdNK is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdNK is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "0000011", 1 => "0000000", 2 => "0000001", 3 => "0000001", 
    4 => "0000001", 5 => "1111110", 6 => "1111111", 7 => "1111110", 
    8 => "0000000", 9 => "1111110", 10 => "0000000", 11 => "0000001", 
    12 => "1111010", 13 => "0000111", 14 => "1111111", 15 => "1111110", 
    16 => "1111110", 17 => "0000011", 18 => "0000011", 19 => "1111110", 
    20 => "1111110", 21 => "1111111", 22 => "1111111", 23 => "1111111", 
    24 => "0000100", 25 => "1111011", 26 => "0000010", 27 => "0000010", 
    28 => "0000001", 29 => "1111110", 30 => "0000001", 31 => "1111100", 
    32 => "0000000", 33 => "0000110", 34 => "1111111", 35 => "1111100", 
    36 => "0000000", 37 => "0000000", 38 => "1111111", 39 => "0000000", 
    40 => "1111101", 41 => "0000001", 42 => "0000000", 43 => "0000110", 
    44 => "0000111", 45 => "1111110", 46 => "1111110", 47 => "0000000", 
    48 => "0000101", 49 => "0000000", 50 => "0000001", 51 => "0000001", 
    52 => "0000011", 53 => "0000110", 54 => "1111011", 55 => "0000010", 
    56 => "0000110", 57 => "0000001", 58 => "0010001", 59 => "1111111", 
    60 => "0000001", 61 => "1111110", 62 => "0000010", 63 => "1111110", 
    64 => "1111101", 65 => "0000111", 66 => "1101010", 67 => "0001000", 
    68 => "1110100", 69 => "0000010", 70 => "0011010", 71 => "1111111", 
    72 => "0010000", 73 => "0010100", 74 => "0001011", 75 => "1111110", 
    76 => "1110100", 77 => "0000000", 78 => "1111001", 79 => "1110001", 
    80 => "1101110", 81 => "0001110", 82 => "1101001", 83 => "1100100", 
    84 => "1111010", 85 => "1110111", 86 => "0000001", 87 => "1111100", 
    88 => "1110101", 89 => "1101111", 90 => "1110101", 91 => "1111110", 
    92 => "0101011", 93 => "1110011", 94 => "0000010", 95 => "1110001", 
    96 => "1111110", 97 => "1110101", 98 => "1110001", 99 => "1110010", 
    100 => "0001101", 101 => "1101111", 102 => "0100011", 103 => "1110011", 
    104 => "0001010", 105 => "1110001", 106 => "1111111", 107 => "0001100", 
    108 => "1111001", 109 => "0010000", 110 => "0001011", 111 => "1101000", 
    112 => "1110011", 113 => "1011100", 114 => "1101111", 115 => "1111011", 
    116 => "1111011", 117 => "0001001", 118 => "0010011", 119 => "0010011", 
    120 => "1110011", 121 => "1101100", 122 => "0010010", 123 => "1111101", 
    124 => "1111001", 125 => "1101101", 126 => "0001000", 127 => "0001110");



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

