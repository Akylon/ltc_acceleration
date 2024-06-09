-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_3Ngs is 
    generic(
             DataWidth     : integer := 7; 
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


architecture rtl of model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_3Ngs is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "0000011", 1 => "0000011", 2 => "0000001", 3 => "0110011", 
    4 => "1111011", 5 => "0000001", 6 => "0000000", 7 => "0000010", 
    8 => "1111110", 9 => "0000010", 10 => "0000001", 11 => "0000000", 
    12 => "0000001", 13 => "0000000", 14 => "0000000", 15 => "1111111", 
    16 => "0000000", 17 => "1111111", 18 => "1111100", 19 => "1111101", 
    20 => "0000111", 21 => "1111111", 22 => "1110110", 23 => "0000010", 
    24 => "0000111", 25 => "1111111", 26 => "0000001", 27 => "0000001", 
    28 => "1111111", 29 => "0000000", 30 => "0000000", 31 => "0000001", 
    32 => "0000001", 33 => "0000000");



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

