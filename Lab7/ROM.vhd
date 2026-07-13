library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM16x8 is
    port (
        Addr : in  std_logic_vector(3 downto 0);
        Q : out std_logic_vector(7 downto 0)
    );
end ROM16x8;

architecture Behavioral of ROM16x8 is
begin
    Q <= std_logic_vector(resize(unsigned(Addr), 8));
end Behavioral;
