library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM16x8 is
    Port (
        clk, reset, WR, RD : in  std_logic;
        Addr : in std_logic_vector(3 downto 0);
        Data : in std_logic_vector(7 downto 0);
        Q : out std_logic_vector(7 downto 0)
    );
end RAM16x8;

architecture Behavioral of RAM16x8 is

    type ram_type is array (0 to 15) of std_logic_vector(7 downto 0);
    signal RAM : ram_type;

begin
    process(clk, reset)
    begin
        if reset = '1' then
            for i in 0 to 15 loop
                RAM(i) <= std_logic_vector(to_unsigned(i, 8));
            end loop;
	    Q <= (others => '0');

        elsif rising_edge(clk) then
            if WR = '1' then
                RAM(to_integer(unsigned(Addr))) <= Data;
	    elsif RD = '1' then
		Q <= RAM(to_integer(unsigned(Addr)));
	    else
		Q <= (others => '0');
            end if;
        end if;
    end process;
end Behavioral;
