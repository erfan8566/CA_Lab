library ieee;
use ieee.std_logic_1164.all;

entity csa_mult is
  port (
    A, B: in std_logic_vector(3 downto 0);
    Z: out std_logic_vector(7 downto 0)
  );
end entity csa_mult;

architecture behavioral of csa_mult is
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

  signal C0, C1, C2 : std_logic_vector(2 downto 0);
  signal S0, S1, S2, C3 : std_logic_vector(1 downto 0);
begin
  gen_and1: for i in 0 to 3 generate
    gen_and2: for j in 0 to 3 generate
  	AB(i, j) <= B(i) and A(j);
    end generate;
  end generate;

  Z(0) <= AB(0, 0);
  ha01 : HA port map(x => AB(0, 1), y => AB(1, 0), s => Z(1), c => C0(0));
  ha02 : HA port map(x => AB(1, 1), y => AB(0, 2), s => S0(0), c => C0(1));
  ha03 : HA port map(x => AB(1, 2), y => AB(0, 3), s => S0(1), c => C0(2));

  fa10 : FA port map(x => AB(2, 0), y => C0(0), cin => S0(0), s => Z(2), c => C1(0));
  fa11 : FA port map(x => AB(2, 1), y => C0(1), cin => S0(1), s => S1(0), c => C1(1));
  fa12 : FA port map(x => AB(2, 2), y => C0(2), cin => AB(1, 3), s => S1(1), c => C1(2));

  fa20 : FA port map(x => AB(3, 0), y => C1(0), cin => S1(0), s => Z(3), c => C2(0));
  fa21 : FA port map(x => AB(3, 1), y => C1(1), cin => S1(1), s => S2(0), c => C2(1));
  fa22 : FA port map(x => AB(3, 2), y => C1(2), cin => AB(2, 3), s => S2(1), c => C2(2));

  ha30 : HA port map(x => C2(0), y => S2(0), s => Z(4), c => C3(0));
  fa31 : FA port map(x => C2(1), y => C3(0), cin => S2(1), s => Z(5), c => C3(1));
  fa32 : FA port map(x => C2(2), y => C3(1), cin => AB(3, 3), s => Z(6), c => Z(7));
end;