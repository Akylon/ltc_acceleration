-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity model_LTC_STATES_V_RAM_AUTO_1R1W is
    generic (
        DataWidth    : integer := 8;
        AddressWidth : integer := 6;
        AddressRange : integer := 64
    );
    port (
        address0 : in  std_logic_vector(AddressWidth-1 downto 0);
        ce0      : in  std_logic;
        we0      : in  std_logic;
        d0       : in  std_logic_vector(DataWidth-1 downto 0);
        q0       : out std_logic_vector(DataWidth-1 downto 0);
        address1 : in  std_logic_vector(AddressWidth-1 downto 0);
        ce1      : in  std_logic;
        we1      : in  std_logic;
        d1       : in  std_logic_vector(DataWidth-1 downto 0);
        q1       : out std_logic_vector(DataWidth-1 downto 0);
        clk      : in  std_logic;
        reset    : in  std_logic
    );
end entity;

architecture arch of model_LTC_STATES_V_RAM_AUTO_1R1W is
    --------------------- Component ---------------------
    component model_LTC_STATES_V_RAM_AUTO_1R1W_ram is
        generic (
            DataWidth : INTEGER;
            AddressWidth : INTEGER;
            AddressRange : INTEGER);
        port (
            address0 : in  std_logic_vector(AddressWidth-1 downto 0);
            ce0      : in  std_logic;
            we0      : in  std_logic;
            d0       : in  std_logic_vector(DataWidth-1 downto 0);
            q0       : out std_logic_vector(DataWidth-1 downto 0);
            address1 : in  std_logic_vector(AddressWidth-1 downto 0);
            ce1      : in  std_logic;
            we1      : in  std_logic;
            d1       : in  std_logic_vector(DataWidth-1 downto 0);
            q1       : out std_logic_vector(DataWidth-1 downto 0);
            clk      : in  std_logic;
            reset    : in  std_logic
        );
    end component;
    --------------------- Local signal ------------------
    signal written : std_logic_vector(AddressRange-1 downto 0) := (others => '0');
    signal q0_ram  : std_logic_vector(DataWidth-1 downto 0);
    signal q0_rom  : std_logic_vector(DataWidth-1 downto 0);
    signal q0_sel  : std_logic;
    signal sel0_sr : std_logic_vector(0 downto 0);
    signal q1_ram  : std_logic_vector(DataWidth-1 downto 0);
    signal q1_rom  : std_logic_vector(DataWidth-1 downto 0);
    signal q1_sel  : std_logic;
    signal sel1_sr : std_logic_vector(0 downto 0);
begin
    --------------------- Instantiation -----------------
    model_LTC_STATES_V_RAM_AUTO_1R1W_ram_u : component model_LTC_STATES_V_RAM_AUTO_1R1W_ram
    generic map (
        DataWidth => DataWidth,
        AddressWidth => AddressWidth,
        AddressRange => AddressRange)
    port map (
        ce0      => ce0,
        address0 => address0,
        we0      => we0,
        d0       => d0,
        q0       => q0_ram,
        ce1      => ce1,
        address1 => address1,
        we1      => we1,
        d1       => d1,
        q1       => q1_ram,
        clk      => clk,
        reset    => reset
    );
    --------------------- Assignment --------------------
    q0     <= q0_ram when q0_sel = '1' else q0_rom;
    q0_sel <= sel0_sr(0);
q0_rom <= (others=>'0'); 
    q1     <= q1_ram when q1_sel = '1' else q1_rom;
    q1_sel <= sel1_sr(0);
q1_rom <= (others=>'0'); 

    process (clk) begin
        if clk'event and clk = '1' then
            if reset = '1' then
                written <= (others => '0');
            else
                if ce0 = '1' and we0 = '1' then
                    written(to_integer(unsigned(address0))) <= '1';
                end if;
                if ce1 = '1' and we1 = '1' then
                    written(to_integer(unsigned(address1))) <= '1';
                end if;
            end if;
        end if;
    end process;

    process (clk) begin
        if clk'event and clk = '1' then
            if ce0 = '1' then
                sel0_sr(0) <= written(to_integer(unsigned(address0)));
            end if;
            if ce1 = '1' then
                sel1_sr(0) <= written(to_integer(unsigned(address1)));
            end if;
        end if;
    end process;

end architecture;
