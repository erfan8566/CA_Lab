library ieee;
use ieee.std_logic_1164.all;

entity tb_RA is
end entity tb_RA;

architecture test of tb_RA is
   component RA is
     port (
       A, B: in std_logic_vector(3 downto 0);
       cin: in std_logic;
       S: out std_logic_vector(3 downto 0);
       cout: out std_logic
     );
   end component RA;

   signal A, B, S: std_logic_vector(3 downto 0);
   signal cin, cout: std_logic;
begin
   ra1 : RA port map(A => A, B => B, cin => cin, S => S, cout => cout);
   
    stimulus_process: process
    begin 
	A <= "1000";
	B <= "1101";
	cin <= '0';
	wait for 10ns;

	cin <= '1';
	wait for 10ns;

	A <= "0011";
	wait for 10ns;

	B <= "1001";
	wait for 10ns;
	
        assert false report "Simulation finished" severity failure;
    end process stimulus_process;
end test;
