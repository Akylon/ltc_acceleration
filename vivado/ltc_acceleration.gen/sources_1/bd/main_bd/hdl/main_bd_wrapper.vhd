--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
--Date        : Sat Jun  8 16:55:28 2024
--Host        : Kampfgurke running 64-bit major release  (build 9200)
--Command     : generate_target main_bd_wrapper.bd
--Design      : main_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity main_bd_wrapper is
  port (
    PMOD_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
end main_bd_wrapper;

architecture STRUCTURE of main_bd_wrapper is
  component main_bd is
  port (
    PMOD_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component main_bd;
begin
main_bd_i: component main_bd
     port map (
      PMOD_tri_o(7 downto 0) => PMOD_tri_o(7 downto 0)
    );
end STRUCTURE;
