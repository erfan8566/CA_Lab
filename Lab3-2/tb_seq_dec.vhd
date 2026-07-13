library ieee;
use ieee.std_logic_1164.all;

entity tb_seq_dec is
end entity tb_seq_dec;

architecture test of tb_seq_dec is
   component seq_dec is
     port (
       input, clk: in std_logic;
       output: out std_logic
     );
   end component seq_dec;

   signal clk, input, output: std_logic;
begin
   m1 : seq_dec port map (input => input, clk => clk, output => output);

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

	input <= '1';
	wait for 20 ns;

	input <= '1';
	wait for 20 ns;

	input <= '0';
	wait for 20 ns;

	input <= '1';
	wait for 20 ns;

        assert false report "Simulation finished" severity failure;
    end process stimulus_process;
end test;