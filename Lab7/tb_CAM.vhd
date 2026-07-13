library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_cam is
end tb_cam;

architecture test of tb_cam is
    component cam is
        port(
            clk, reset, rd, wr : in std_logic;
            query, mask, din   : in std_logic_vector(7 downto 0);

            match : out std_logic_vector(7 downto 0);
            hit   : out std_logic
        );
    end component;

    signal clk, reset, rd, wr : std_logic := '0';
    signal query, mask, din : std_logic_vector(7 downto 0) := (others => '0');
    signal match : std_logic_vector(7 downto 0);
    signal hit   : std_logic;

begin

    cam1 : cam
        port map (
            clk   => clk,
            reset => reset,
            rd    => rd,
            wr    => wr,
            query => query,
            mask  => mask,
            din   => din,
            match => match,
            hit   => hit
        );

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

        query <= x"00";
        mask  <= x"FF";
        din   <= x"11";
        wr    <= '1';

        wait until rising_edge(clk);
        wr <= '0';
        wait for 10 ns;

        query <= x"00";
        mask  <= x"FF";
        din   <= x"22";
        wr    <= '1';

        wait until rising_edge(clk);
        wr <= '0';
        wait for 10 ns;

        query <= x"22";
        mask  <= x"FF";
        rd    <= '1';

        wait until rising_edge(clk);
        rd <= '0';
        wait for 10 ns;

        query <= x"00";
        mask  <= x"FF";
        din   <= x"33";
        wr    <= '1';

        wait until rising_edge(clk);
        wr <= '0';
        wait for 10 ns;

        query <= x"11";
        mask  <= x"FF";
        rd    <= '1';

        wait until rising_edge(clk);
        rd <= '0';
        wait for 10 ns;

        query <= x"07";
        mask  <= x"FF";
        rd    <= '1';

        wait until rising_edge(clk);
        rd <= '0';
        wait for 20 ns;

        assert false report "Simulation Finished" severity failure;
    end process;
end test;
