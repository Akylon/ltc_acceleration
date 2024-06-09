-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_1tde is 
    generic(
             DataWidth     : integer := 8; 
             AddressWidth     : integer := 6; 
             AddressRange    : integer := 34
    ); 
    port (
 
          address0        : in std_logic_vector(AddressWidth-1 downto 0); 
          ce0             : in std_logic; 
          q0              : out std_logic_vector(DataWidth-1 downto 0);

          reset               : in std_logic;
          clk                 : in std_logic
    ); 
end entity; 


architecture rtl of model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_1tde is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "00000010", 1 => "11111110", 2 => "00000001", 3 => "00000010", 
    4 => "00000001", 5 => "00000011", 6 => "11111110", 7 => "11111111", 
    8 => "11111111", 9 => "11111101", 10 => "00000001", 11 => "11111111", 
    12 => "00000001", 13 => "11111111", 14 => "00000000", 15 => "11111111", 
    16 => "00000000", 17 => "11111100", 18 => "00000100", 19 => "11111101", 
    20 => "01000000", 21 => "11111111", 22 => "11111101", 23 => "00000000", 
    24 => "00000001", 25 => "00000010", 26 => "00000000", 27 => "11111111", 
    28 => "00000001", 29 => "00000000", 30 => "00000000", 31 => "00000000", 
    32 => "00000000", 33 => "00000000");



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

