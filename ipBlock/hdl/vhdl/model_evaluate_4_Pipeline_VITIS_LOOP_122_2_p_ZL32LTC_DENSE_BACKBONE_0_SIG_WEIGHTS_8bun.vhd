-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_8bun is 
    generic(
             DataWidth     : integer := 5; 
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


architecture rtl of model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_8bun is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "11101", 1 => "11111", 2 => "00010", 3 => "00101", 
    4 => "11001", 5 => "11110", 6 => "00001", 7 => "10100", 
    8 => "00000", 9 => "00010", 10 => "11111", 11 => "00000", 
    12 => "11111", 13 => "00001", 14 => "00001", 15 => "00000", 
    16 => "00000", 17 => "11101", 18 => "00011", 19 => "11110", 
    20 => "00111", 21 => "00010", 22 => "00010", 23 => "00011", 
    24 => "00000", 25 => "00001", 26 => "00000", 27 => "11110", 
    28 => "11110", 29 => "00001", 30 => "00001", 31 => "00000", 
    32 => "11111", 33 => "00001");



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

