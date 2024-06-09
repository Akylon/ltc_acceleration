-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_3eOg is 
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


architecture rtl of model_evaluate_4_Pipeline_VITIS_LOOP_122_2_p_ZL32LTC_DENSE_BACKBONE_0_SIG_WEIGHTS_3eOg is 
 
signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 

type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 

signal mem0 : mem_array := (
    0 => "11111111", 1 => "00000001", 2 => "00000001", 3 => "00000001", 
    4 => "00000000", 5 => "01001100", 6 => "11111111", 7 => "00000000", 
    8 => "00000001", 9 => "00000000", 10 => "00000000", 11 => "00000000", 
    12 => "00000000", 13 => "00000000", 14 => "00000000", 15 => "00000000", 
    16 => "00000000", 17 => "00000001", 18 => "00000010", 19 => "00000001", 
    20 => "00011011", 21 => "00000001", 22 => "11111110", 23 => "11111111", 
    24 => "11111111", 25 => "11111100", 26 => "11111110", 27 => "00000010", 
    28 => "11111111", 29 => "11111111", 30 => "00000010", 31 => "11111110", 
    32 => "11111110", 33 => "11111111");



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

