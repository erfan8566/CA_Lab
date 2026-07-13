library ieee;
use ieee.std_logic_1164.all;

entity gen is
   port (
     A, B: in std_logic_vector(3 downto 0);
     G, P: out std_logic_vector(3 downto 0)
   );
end entity gen;

architecture behavioral of gen is
begin
   G <= A and B;
   P <= A or B;
end;

library ieee;
use ieee.std_logic_1164.all;

entity CLA is
   port (
      A, B: in std_logic_vector(3 downto 0);
      cin: in std_logic;
      S: out std_logic_vector(3 downto 0);
      cout: out std_logic
);
end entity CLA;

architecture behavioral of CLA is
   component gen is
     port (
       A, B: in std_logic_vector(3 downto 0);
       G, P: out std_logic_vector(3 downto 0)
     );
   end component gen;

   signal c, G_int, P_int: std_logic_vector(3 downto 0);
begin

   g_inst : gen port map(A => A, B => B, G => G_int, P => P_int);

   c(0) <= G_int(0) or (P_int(0) and cin);
   c(1) <= G_int(1) or (P_int(1) and G_int(0)) or (P_int(1) and P_int(0) and cin);
   c(2) <= G_int(2) or (P_int(2) and G_int(1)) or (P_int(2) and P_int(1) and G_int(0)) or (P_int(2) and P_int(1) and P_int(0) and cin);
   cout <= G_int(3) or (P_int(3) and G_int(2)) or (P_int(3) and P_int(2) and G_int(1)) or (P_int(3) and P_int(2) and P_int(1) and G_int(0)) or (P_int(3) and P_int(2) and P_int(1) and P_int(0) and cin);
   
   S(0) <= A(0) xor B(0) xor cin;
   S(1) <= A(1) xor B(1) xor c(0);
   S(2) <= A(2) xor B(2) xor c(1);
   S(3) <= A(3) xor B(3) xor c(2);

end architecture behavioral;
