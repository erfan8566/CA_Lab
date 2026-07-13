library ieee;
use ieee.std_logic_1164.all;

entity arr_mult is
  port (
    A, B: in std_logic_vector(3 downto 0);
    Z: out std_logic_vector(7 downto 0)
  );
end entity arr_mult;

architecture behavioral of arr_mult is
  type matrix is array(0 to 3, 0 to 3) of std_logic;
  signal AB : matrix;

  component RA is
    port (
      A, B: in std_logic_vector(3 downto 0);
      cin: in std_logic;
      S: out std_logic_vector(3 downto 0);
      cout: out std_logic
    );
  end component RA;

  signal S1, S2, S3 : std_logic_vector(3 downto 0);
  signal A_vec, B_vec, A_vec2, B_vec2, A_vec3, B_vec3 : std_logic_vector(3 downto 0);
  signal c1, c2, c3 : std_logic;
  signal Z_temp : std_logic_vector(7 downto 0);
  
begin
  gen_and1: for i in 0 to 3 generate
    gen_and2: for j in 0 to 3 generate
      AB(i, j) <= B(i) and A(j);
    end generate;
  end generate;

  Z_temp(0) <= AB(0, 0);
  
  A_vec <= '0' & AB(0, 3) & AB(0, 2) & AB(0, 1);
  B_vec <= AB(1, 3) & AB(1, 2) & AB(1, 1) & AB(1, 0);
  
  ra1 : RA port map(A => A_vec, B => B_vec, cin => '0', S => S1, cout => c1);
  Z_temp(1) <= S1(0);
  
  A_vec2 <= c1 & S1(3) & S1(2) & S1(1);
  B_vec2 <= AB(2, 3) & AB(2, 2) & AB(2, 1) & AB(2, 0);
  
  ra2 : RA port map(A => A_vec2, B => B_vec2, cin => '0', S => S2, cout => c2);
  Z_temp(2) <= S2(0);
  
  A_vec3 <= c2 & S2(3) & S2(2) & S2(1);
  B_vec3 <= AB(3, 3) & AB(3, 2) & AB(3, 1) & AB(3, 0);
  
  ra3 : RA port map(A => A_vec3, B => B_vec3, cin => '0', S => S3, cout => c3);

  gen_z: for i in 0 to 3 generate
      Z_temp(i + 3) <= S3(i);
    end generate;
  Z_temp(7) <= c3;
  
  Z <= Z_temp;

end architecture;