library ieee;
use ieee.std_logic_1164.all;

entity tb_tff is
end entity tb_tff;

architecture test of tb_tff is
   component tff is
     port (
       t, clk, reset: in std_logic;
       q: out std_logic
     );
   end component tff;

   signal t, clk, reset, q: std_logic;
begin
   tff1: tff port map (t => t, clk => clk, reset => reset, q => q);
   
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
      t <= '0';
      wait for 20 ns;
      
      reset <= '1';
      wait for 20 ns;
      
      t <= '1';
      wait for 20 ns;
      
      t <= '0';
      wait for 20 ns;
      
      t <= '1';
      wait for 20 ns;

      reset <= '0';
      wait for 20 ns;
      
      reset <= '1';
      wait for 20 ns;
      assert false report "Simulation finished at 200 ns" severity failure;
   end process stimulus_process;
end test;
