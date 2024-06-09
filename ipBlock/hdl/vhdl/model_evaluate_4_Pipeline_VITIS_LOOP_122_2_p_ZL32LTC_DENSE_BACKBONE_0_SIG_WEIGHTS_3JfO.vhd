-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_3JfO is 
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


architecture rtl of model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_3JfO is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1111101", 1 => "1110100", 2 => "0000001", 3 => "1110010", 
    4 => "1111100", 5 => "1111111", 6 => "0000001", 7 => "0000001", 
    8 => "1111011", 9 => "1111111", 10 => "1111101", 11 => "0000000", 
    12 => "1111101", 13 => "0000000", 14 => "0000001", 15 => "0000000", 
    16 => "1111111", 17 => "1111101", 18 => "1111111", 19 => "0101010", 
    20 => "1111011", 21 => "1111100", 22 => "0000110", 23 => "0000110", 
    24 => "0000010", 25 => "1111111", 26 => "0000000", 27 => "0000011", 
    28 => "0000001", 29 => "0000000", 30 => "0000000", 31 => "1111100", 
    32 => "0000000", 33 => "0000001");



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

