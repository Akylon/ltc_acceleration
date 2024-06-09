-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdZM is 
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


architecture rtl of model_evaluate_3_Pipeline_VITIS_LOOP_122_2_p_ZL34LTC_DENSE_BACKBONE_0_STATE_WEIGHTSdZM is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "11001101", 1 => "00101001", 2 => "00010100", 3 => "11110111", 
    4 => "11101001", 5 => "11100100", 6 => "00001101", 7 => "11110010", 
    8 => "00011011", 9 => "11110000", 10 => "11111010", 11 => "11000110", 
    12 => "00000000", 13 => "00010101", 14 => "00001101", 15 => "10110100", 
    16 => "11111010", 17 => "11100011", 18 => "11111111", 19 => "11101111", 
    20 => "11110110", 21 => "11110001", 22 => "00001001", 23 => "00010111", 
    24 => "11011011", 25 => "00100010", 26 => "11000100", 27 => "00100101", 
    28 => "11101110", 29 => "11111100", 30 => "00001010", 31 => "11011001", 
    32 => "11111111", 33 => "00101001", 34 => "11000010", 35 => "00000000", 
    36 => "11101010", 37 => "11111101", 38 => "00101011", 39 => "00001001", 
    40 => "00010100", 41 => "11010011", 42 => "00001110", 43 => "00010101", 
    44 => "00001000", 45 => "11111100", 46 => "11011100", 47 => "00001001", 
    48 => "11110101", 49 => "00101011", 50 => "11111011", 51 => "00010011", 
    52 => "00001010", 53 => "11101000", 54 => "00100111", 55 => "00001101", 
    56 => "11010010", 57 => "11101110", 58 => "00001001", 59 => "11111110", 
    60 => "11100100", 61 => "11010101", 62 => "11011100", 63 => "11001010", 
    64 => "00001011", 65 => "00001011", 66 => "00000011", 67 => "11110100", 
    68 => "11110010", 69 => "00000000", 70 => "00000011", 71 => "11111001", 
    72 => "11101101", 73 => "00000011", 74 => "11111011", 75 => "11100110", 
    76 => "00100010", 77 => "11111001", 78 => "11111001", 79 => "11110001", 
    80 => "00001110", 81 => "11111101", 82 => "11101110", 83 => "11110010", 
    84 => "00000100", 85 => "00000001", 86 => "00001011", 87 => "11110111", 
    88 => "00000011", 89 => "00001011", 90 => "11110010", 91 => "11110100", 
    92 => "00000100", 93 => "11111010", 94 => "11111011", 95 => "11111011", 
    96 => "11110101", 97 => "00010011", 98 => "11110101", 99 => "11110111", 
    100 => "11110100", 101 => "11111010", 102 => "11111111", 103 => "00000000", 
    104 => "00001110", 105 => "00000001", 106 => "00001001", 107 => "00000000", 
    108 => "11111110", 109 => "11110100", 110 => "11110001", 111 => "00000011", 
    112 => "00000110", 113 => "00001001", 114 => "11101111", 115 => "11100011", 
    116 => "00000011", 117 => "11111100", 118 => "11110001", 119 => "11111111", 
    120 => "11100111", 121 => "11101100", 122 => "00000010", 123 => "11111001", 
    124 => "11110101", 125 => "00000001", 126 => "00000010", 127 => "00000010");



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

