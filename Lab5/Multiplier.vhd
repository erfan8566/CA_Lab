library ieee;
use ieee.std_logic_1164.all;

entity mult is
  port (
    A, B: in std_logic_vector(3 downto 0);
    Z: out std_logic_vector(7 downto 0)
  );
end entity mult;

architecture behavioral of mult is
  type matrix is array(0 to 3, 0 to 3) of std_logic;
  signal AB : matrix;

  component HA is
    port (
      x, y: in std_logic;
      s, c: out std_logic
    );
  end component HA;

  component FA is
    port (
      x, y, cin: in std_logic;
      s, c: out std_logic
    );
  end component FA;

  signal C0, C1 : std_logic_vector(3 downto 0);
  signal S0, S1, C2 : std_logic_vector(2 downto 0);
begin
  gen_and1: for i in 0 to 3 generate
    gen_and2: for j in 0 to 3 generate
  	AB(i, j) <= B(i) and A(j);
    end generate;
  end generate;

  Z(0) <= AB(0, 0);
  ha01 : HA port map(x => AB(0, 1), y => AB(1, 0), s => Z(1), c => C0(0));
  fa01 : FA port map(x => AB(0, 2), y => AB(1, 1), cin => C0(0), s => S0(0), c => C0(1));
  fa02 : FA port map(x => AB(0, 3), y => AB(1, 2), cin => C0(1), s => S0(1), c => C0(2));
  ha02 : HA port map(x => AB(1, 3), y => C0(2), s => S0(2), c => C0(3));

  ha10 : HA port map(x => AB(2, 0), y => S0(0), s => Z(2), c => C1(0));
  fa10 : FA port map(x => AB(2, 1), y => S0(1), cin => C1(0), s => S1(0), c => C1(1));
  fa11 : FA port map(x => AB(2, 2), y => S0(2), cin => C1(1), s => S1(1), c => C1(2));
  fa12 : FA port map(x => AB(2, 3), y => C0(3), cin => C1(2), s => S1(2), c => C1(3));

  ha20 : HA port map(x => AB(3, 0), y => S1(0), s => Z(3), c => C2(0));
  fa20 : FA port map(x => AB(3, 1), y => S1(1), cin => C2(0), s => Z(4), c => C2(1));
  fa21 : FA port map(x => AB(3, 2), y => S1(2), cin => C2(1), s => Z(5), c => C2(2));
  fa22 : FA port map(x => AB(3, 3), y => C1(3), cin => C2(2), s => Z(6), c => Z(7));
end;