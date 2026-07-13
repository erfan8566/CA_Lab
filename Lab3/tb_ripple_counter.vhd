library ieee;
use ieee.std_logic_1164.all;

entity tb_cnt is
end entity tb_cnt;

architecture test of tb_cnt is
   component cnt is
     port (
      clk, reset: in std_logic;
      Q: out std_logic_vector(3 downto 0)
     );
   end component cnt;

   signal clk, reset: std_logic;
   signal Q: std_logic_vector(3 downto 0);
begin
  cnt1: cnt port map(clk => clk, reset => reset, Q => Q);  

  clk_process: process
   begin
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
   end process clk_process;

   reset_process: process
   begin
     reset <= '0';
     wait for 20 ns;
     reset <= '1';
     wait;
   end process reset_process;

   assert_now: process
   begin
     wait for 400 ns;
     assert false report "Simulation finished at 200 ns" severity failure;
   end process;
end test;
