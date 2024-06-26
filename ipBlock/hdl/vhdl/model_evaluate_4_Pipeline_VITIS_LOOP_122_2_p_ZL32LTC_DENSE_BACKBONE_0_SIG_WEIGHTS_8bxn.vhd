-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_8bxn is 
    generic(
             DataWidth     : integer := 4; 
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


architecture rtl of model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_8bxn is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1110", 1 => "0000", 2 => "0000", 3 => "0110", 
    4 => "0100", 5 => "0000", 6 => "1111", 7 => "0001", 
    8 => "0000", 9 => "1111", 10 => "0000", 11 => "0001", 
    12 => "0011", 13 => "0000", 14 => "0000", 15 => "1111", 
    16 => "1110", 17 => "0011", 18 => "1100", 19 => "1110", 
    20 => "0011", 21 => "0001", 22 => "0011", 23 => "0011", 
    24 => "0100", 25 => "1101", 26 => "0001", 27 => "1110", 
    28 => "0000", 29 => "1111", 30 => "1111", 31 => "0000", 
    32 => "1101", 33 => "0001");



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

