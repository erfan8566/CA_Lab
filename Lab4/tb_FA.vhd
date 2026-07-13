library ieee;
use ieee.std_logic_1164.all;

entity tb_FA is
end entity tb_FA;

architecture test of tb_FA is
   component FA is
     port (
       x, y, cin: in std_logic;
       S, cout: out std_logic
     );
   end component FA;

   signal x, y, cin, S, cout: std_logic;
begin
   fa1 : FA port map(x => x, y => y, cin => cin, S => S, cout => cout);
   
    stimulus_process: process
    begin 
	x <= '0';
	y <= '0';
	cin <= '0';
	wait for 10ns;

	cin <= '1';
	wait for 10ns;

	x <= '1';
	wait for 10ns;

	y <= '1';
	wait for 10ns;
	
        assert false report "Simulation finished" severity failure;
    end process stimulus_process;
end test;
