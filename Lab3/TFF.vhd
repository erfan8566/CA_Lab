library ieee;
use ieee.std_logic_1164.all;

entity tff is
   port (
    t, clk, reset: in std_logic;
    q: out std_logic
);
end entity tff;

architecture behavioral of tff is
   component dff is
     port (
       d, clk, reset: in std_logic;
       q: out std_logic
     );
   end component dff;

   signal n, q_internal: std_logic;
begin
   n <= q_internal xor t;
   dff1: dff port map(d => n, clk => clk, reset => reset, q => q_internal);
   q <= q_internal;
end behavioral;