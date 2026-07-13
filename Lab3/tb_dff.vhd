library ieee;
use ieee.std_logic_1164.all;

entity tb_dff is
end entity tb_dff;

architecture test of tb_dff is
   component dff is
     port (
       d, clk, reset: in std_logic;
       q: out std_logic
     );
   end component dff;

   signal d, clk, reset, q: std_logic;
begin
   dff1: dff port map (d => d, clk => clk, reset => reset, q => q);
   
   clk_process: process
   begin
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
   end process clk_process;

   stimulus_process: process
   begin
      reset <= '0';
      d <= '0';
      wait for 20 ns;
      
      reset <= '1';
      wait for 20 ns;
      
      d <= '1';
      wait for 20 ns;
      
      d <= '0';
      wait for 20 ns;
      
      d <= '1';
      wait for 20 ns;

      reset <= '0';
      wait for 20 ns;
      
      reset <= '1';
      wait for 20 ns;
      assert false report "Simulation finished at 200 ns" severity failure;
   end process stimulus_process;
end test;
