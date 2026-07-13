library ieee;
use ieee.std_logic_1164.all;

entity dff is
   port (
    d, clk, reset: in std_logic;
    q: out std_logic
);
end entity dff;

architecture behavioral of dff is
begin
   p: process(clk, reset) begin
      if (reset = '0') then
	 q <= '0';
      elsif (clk'event and clk = '1') then
	 q <= d;
      end if;
   end process;
end behavioral;