library ieee;
use ieee.std_logic_1164.all;

entity cnt is
  port (
    clk, reset: in std_logic;
    Q: out std_logic_vector(3 downto 0)
  );
end entity cnt;

architecture behavioral of cnt is
   component tff is
     port (
       t, clk, reset: in std_logic;
       q: out std_logic
     );
   end component tff;

   signal q_int, q_n: std_logic_vector(3 downto 0);
begin
   tff1: tff port map(t => '1', clk => clk, reset => reset, q => q_int(0));
   tff2: tff port map(t => '1', clk => q_n(0), reset => reset, q => q_int(1));
   tff3: tff port map(t => '1', clk => q_n(1), reset => reset, q => q_int(2));
   tff4: tff port map(t => '1', clk => q_n(2), reset => reset, q => q_int(3));
   Q <= q_int;
   q_n <= not q_int;
end behavioral;