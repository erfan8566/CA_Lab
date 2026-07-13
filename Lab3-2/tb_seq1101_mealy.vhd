library ieee;
use ieee.std_logic_1164.all;

entity tb_mealy1101 is
end entity tb_mealy1101;

architecture test of tb_mealy1101 is
   component mealy1101 is
     port (
       input, clk: in std_logic;
       output: out std_logic
     );
    end component mealy1101;

    signal clk, input, output: std_logic;
begin
    m1 : mealy1101 port map (input => input, clk => clk, output => output);

    clk_process: process
    begin
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
    end process clk_process;

    stimulus_process: process
    begin
        input <= '0';
	wait for 20 ns;

	input <= '1';
	wait for 20 ns;

	input <= '0';
	wait for 20 ns;

	input <= '1';
	wait for 20 ns;

	input <= '1';
	wait for 20 ns;

	input <= '0';
	wait for 20 ns;

	input <= '1';
	wait for 20 ns;

	input <= '1';
	wait for 20 ns;

	input <= '0';
	wait for 20 ns;

	input <= '1';
	wait for 20 ns;

	input <= '0';
	wait for 20 ns;

        assert false report "Simulation finished" severity failure;
    end process stimulus_process;
end test;