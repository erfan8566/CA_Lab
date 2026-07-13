library ieee;
use ieee.std_logic_1164.all;

entity FA is
  port (
    x, y, cin: in std_logic;
    s, c: out std_logic
  );
end entity FA;

architecture behavioral of FA is
begin
   s <= x xor y xor cin;
   c <= (x and y) or (x and cin) or (y and cin);
end;