library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_DPRAM16x8 is
end tb_DPRAM16x8;

architecture test of tb_DPRAM16x8 is

    component DPRAM16x8 is
        port (
            clk   : in std_logic;
            reset : in std_logic;

            WA, RA : in std_logic;
            AddrA  : in std_logic_vector(3 downto 0);
            DataA  : in std_logic_vector(7 downto 0);
            QA     : out std_logic_vector(7 downto 0);

            WB, RB : in std_logic;
            AddrB  : in std_logic_vector(3 downto 0);
            DataB  : in std_logic_vector(7 downto 0);
            QB     : out std_logic_vector(7 downto 0)
        );
    end component;

    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';

    signal WA, RA : std_logic := '0';
    signal WB, RB : std_logic := '0';

    signal AddrA, AddrB : std_logic_vector(3 downto 0) := (others => '0');
    signal DataA, DataB : std_logic_vector(7 downto 0) := (others => '0');

    signal QA, QB : std_logic_vector(7 downto 0);

begin

    dpRAM : DPRAM16x8
        port map (
            clk   => clk,
            reset => reset,

            WA => WA,
            RA => RA,
            AddrA => AddrA,
            DataA => DataA,
            QA => QA,

            WB => WB,
            RB => RB,
            AddrB => AddrB,
            DataB => DataB,
            QB => QB
        );

    ------------------------------------------------------------
    -- CLOCK
    ------------------------------------------------------------
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    stim_proc : process
    begin
        reset <= '1';
        wait for 12 ns;
        reset <= '0';

        wait for 10 ns;

        AddrA <= "0001";
        DataA <= x"11";
        WA <= '1';

        AddrB <= "0010";
        DataB <= x"22";
        WB <= '1';

        wait until rising_edge(clk);

        WA <= '0';
        WB <= '0';
        wait for 10 ns;

        AddrA <= "0001";
        AddrB <= "0010";

        RA <= '1';
        RB <= '1';

        wait until falling_edge(clk);

        RA <= '0';
        RB <= '0';

        wait for 10 ns;  -- IDLE CYCLE

        assert false report "Simulation Finished" severity failure;
    end process;
end test;
