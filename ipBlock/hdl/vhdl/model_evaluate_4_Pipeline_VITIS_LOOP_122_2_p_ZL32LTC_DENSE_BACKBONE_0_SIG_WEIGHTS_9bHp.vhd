-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_9bHp is 
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


architecture rtl of model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_9bHp is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "111011", 1 => "000111", 2 => "111011", 3 => "000001", 
    4 => "111100", 5 => "111000", 6 => "111100", 7 => "000011", 
    8 => "000000", 9 => "111101", 10 => "000000", 11 => "000001", 
    12 => "000000", 13 => "000001", 14 => "000001", 15 => "111110", 
    16 => "111111", 17 => "111001", 18 => "111111", 19 => "000110", 
    20 => "101110", 21 => "110001", 22 => "000010", 23 => "111101", 
    24 => "111101", 25 => "000010", 26 => "111110", 27 => "000100", 
    28 => "111110", 29 => "111110", 30 => "000000", 31 => "111110", 
    32 => "111111", 33 => "000000");



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

