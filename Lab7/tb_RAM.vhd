library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_RAM16x8 is
end tb_RAM16x8;

architecture test of tb_RAM16x8 is
    component RAM16x8 is
      port (
        clk, reset, WR, RD : in std_logic;
        Addr : in std_logic_vector(3 downto 0);
        Data : in std_logic_vector(7 downto 0);
        Q : out std_logic_vector(7 downto 0)
      );
    end component;

    signal clk, reset, WR, RD : std_logic := '0';
    signal Addr : std_logic_vector(3 downto 0) := (others => '0');
    signal Data : std_logic_vector(7 downto 0) := (others => '0');
    signal Q : std_logic_vector(7 downto 0);
begin
    ram : RAM16x8
        port map (
            clk   => clk,
            reset => reset,
            WR    => WR,
            RD    => RD,
            Addr  => Addr,
            Data  => Data,
            Q     => Q
        );

    clk_process : process
    begin
        clk <= '0';
        wait for 5 ns;

        clk <= '1';
        wait for 5 ns;
    end process;

    stim_proc : process
    begin
        reset <= '1';
        wait for 12 ns;
        reset <= '0';

        wait for 10 ns;

        Addr <= "0011";
        RD <= '1';
        wait until rising_edge(clk);
        RD <= '0';
        wait for 10 ns;

        Addr <= "1010";
        RD <= '1';
        wait until rising_edge(clk);
        RD <= '0';
        wait for 10 ns;

        Addr <= "0101";
        Data <= x"AA";
        WR <= '1';
        wait until falling_edge(clk);
        WR <= '0';
        wait for 10 ns;

        Addr <= "0101";
        RD <= '1';
        wait until rising_edge(clk);
        RD <= '0';
        wait for 10 ns;

        assert false report "Simulation Finished" severity failure;
    end process;
end test;