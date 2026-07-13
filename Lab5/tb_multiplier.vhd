library ieee;
use ieee.std_logic_1164.all;

entity mult_tb is
end entity mult_tb;

architecture test of mult_tb is
  component mult is
    port (
      A, B: in std_logic_vector(3 downto 0);
      Z: out std_logic_vector(7 downto 0)
    );
  end component;

  signal A, B : std_logic_vector(3 downto 0);
  signal Z : std_logic_vector(7 downto 0);
  
begin
  m1: mult port map (A => A, B => B, Z => Z);

  process
   begin 
    A <= "0101";
    B <= "0011";
    wait for 10 ns;
    
    A <= "1100";
    B <= "1111";
    wait for 10 ns;
    
    assert false report "Simulation finished" severity failure;
  end process;
end test;
