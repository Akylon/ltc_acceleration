-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_9bGp is 
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


architecture rtl of model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_9bGp is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "1100", 1 => "0010", 2 => "1111", 3 => "0001", 
    4 => "0100", 5 => "1100", 6 => "0000", 7 => "0010", 
    8 => "1110", 9 => "0010", 10 => "1101", 11 => "0000", 
    12 => "1111", 13 => "0000", 14 => "0000", 15 => "0000", 
    16 => "0010", 17 => "0000", 18 => "1111", 19 => "0000", 
    20 => "1011", 21 => "1001", 22 => "0010", 23 => "0000", 
    24 => "0000", 25 => "1100", 26 => "0001", 27 => "0000", 
    28 => "1111", 29 => "0010", 30 => "0001", 31 => "0000", 
    32 => "1111", 33 => "1111");



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

