library ieee;
use ieee.std_logic_1164.all;

entity CSA is
   port (
      A, B: in std_logic_vector(3 downto 0);
      cin: in std_logic;
      S: out std_logic_vector(3 downto 0);
      cout: out std_logic
);
end entity CSA;

architecture behavioral of CSA is
   component RA is
     port (
        A, B: in std_logic_vector(3 downto 0);
        cin: in std_logic;
        S: out std_logic_vector(3 downto 0);
        cout: out std_logic
     );
    end component RA;

    signal S0, S1: std_logic_vector(3 downto 0);
    signal c0, c1: std_logic; 
begin
    ra0 : RA port map (A => A, B => B, cin => '0', S => S0, cout => c0);
    ra1 : RA port map (A => A, B => B, cin => '1', S => S1, cout => c1);

    S <= S0 when cin = '0' else S1;
    cout <= c0 when cin = '0' else c1;
end behavioral;