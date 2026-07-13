library ieee;
use ieee.std_logic_1164.all;

entity HA is
  port (
    x, y: in std_logic;
    s, c: out std_logic
  );
end entity HA;

architecture behavioral of HA is
begin
   s <= x xor y;
   c <= x and y;
end;