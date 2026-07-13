library ieee;
use ieee.std_logic_1164.all;

entity RA is
   port (
      A, B: in std_logic_vector(3 downto 0);
      cin: in std_logic;
      S: out std_logic_vector(3 downto 0);
      cout: out std_logic
);
end entity RA;

architecture behavioral of RA is
   component FA is
     port (
       x, y, cin: in std_logic;
       s, c: out std_logic
     );
   end component FA;

   signal c: std_logic_vector(2 downto 0);
begin
   fa1 : FA port map(x => A(0), y => B(0), cin => cin, s => S(0), c => c(0));
   fa2 : FA port map(x => A(1), y => B(1), cin => c(0), s => S(1), c => c(1));
   fa3 : FA port map(x => A(2), y => B(2), cin => c(1), s => S(2), c => c(2));
   fa4 : FA port map(x => A(3), y => B(3), cin => c(2), s => S(3), c => cout);
end behavioral;
