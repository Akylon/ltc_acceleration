-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_1b3s is 
    generic(
             DataWidth     : integer := 6; 
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


architecture rtl of model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_1b3s is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "111100", 1 => "000011", 2 => "000010", 3 => "000000", 
    4 => "111111", 5 => "000000", 6 => "000111", 7 => "000000", 
    8 => "111101", 9 => "111101", 10 => "000001", 11 => "000010", 
    12 => "000001", 13 => "000000", 14 => "000000", 15 => "111110", 
    16 => "000001", 17 => "111100", 18 => "000101", 19 => "111100", 
    20 => "000011", 21 => "000100", 22 => "011111", 23 => "111111", 
    24 => "111110", 25 => "111111", 26 => "111101", 27 => "111111", 
    28 => "000001", 29 => "000001", 30 => "111111", 31 => "000001", 
    32 => "000000", 33 => "000010");



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

