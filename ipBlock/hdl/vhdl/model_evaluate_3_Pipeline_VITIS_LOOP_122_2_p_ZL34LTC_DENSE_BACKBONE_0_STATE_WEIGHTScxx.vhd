-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScxx is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTScxx is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1110101", 1 => "1111011", 2 => "1111110", 3 => "1110100", 
    4 => "0000011", 5 => "1111000", 6 => "1111101", 7 => "1111001", 
    8 => "1111000", 9 => "0000111", 10 => "1110101", 11 => "0001110", 
    12 => "1110011", 13 => "1111100", 14 => "0010011", 15 => "0001101", 
    16 => "1111011", 17 => "0000001", 18 => "1111111", 19 => "0000000", 
    20 => "1111110", 21 => "1111100", 22 => "1111100", 23 => "0000100", 
    24 => "0000000", 25 => "0000010", 26 => "0001010", 27 => "0000100", 
    28 => "0001010", 29 => "0000110", 30 => "1101000", 31 => "1110110", 
    32 => "1111111", 33 => "0000000", 34 => "0001000", 35 => "1110001", 
    36 => "0000001", 37 => "1111101", 38 => "0000101", 39 => "1111001", 
    40 => "0001111", 41 => "0000000", 42 => "0000111", 43 => "1101101", 
    44 => "1110010", 45 => "1111100", 46 => "1111101", 47 => "1111111", 
    48 => "0011110", 49 => "0000110", 50 => "0000000", 51 => "0000111", 
    52 => "1110101", 53 => "0000010", 54 => "0001110", 55 => "0000100", 
    56 => "1110000", 57 => "1111111", 58 => "0100111", 59 => "1111101", 
    60 => "0000010", 61 => "0001110", 62 => "1110101", 63 => "0010110", 
    64 => "0000000", 65 => "0000011", 66 => "0000001", 67 => "1111110", 
    68 => "0000100", 69 => "0000001", 70 => "1111111", 71 => "1111111", 
    72 => "1111101", 73 => "0000001", 74 => "1111011", 75 => "0000010", 
    76 => "1111111", 77 => "1111011", 78 => "0000100", 79 => "1111100", 
    80 => "0000001", 81 => "0000010", 82 => "1111110", 83 => "1111101", 
    84 => "0000001", 85 => "1111111", 86 => "1111111", 87 => "0000001", 
    88 => "0000110", 89 => "1111101", 90 => "0000011", 91 => "1111110", 
    92 => "0000011", 93 => "0000010", 94 => "1111101", 95 => "0000001", 
    96 => "1111111", 97 => "0000010", 98 => "0000100", 99 => "1111100", 
    100 => "1111110", 101 => "1111101", 102 => "1111100", 103 => "1111110", 
    104 => "1111111", 105 => "0000001", 106 => "0000010", 107 => "0000010", 
    108 => "1111111", 109 => "0000000", 110 => "1111110", 111 => "0000001", 
    112 => "1111111", 113 => "0000000", 114 => "0000100", 115 => "1110100", 
    116 => "0000001", 117 => "0000100", 118 => "0000011", 119 => "1111100", 
    120 => "1111111", 121 => "1111110", 122 => "1111101", 123 => "1111111", 
    124 => "0000110", 125 => "0000011", 126 => "0000001", 127 => "0000001");



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
