library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DPRAM16x8 is
    port (
        clk   : in std_logic;
        reset : in std_logic;

        WA, RA : in std_logic;
        AddrA : in std_logic_vector(3 downto 0);
        DataA : in std_logic_vector(7 downto 0);
        QA : out std_logic_vector(7 downto 0);

        -- PORT B
        WB, RB : in std_logic;
        AddrB : in std_logic_vector(3 downto 0);
        DataB : in std_logic_vector(7 downto 0);
        QB : out std_logic_vector(7 downto 0)
    );
end DPRAM16x8;

architecture Behavioral of DPRAM16x8 is
    type ram_type is array (0 to 15) of std_logic_vector(7 downto 0);
    signal RAM : ram_type;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            for i in 0 to 15 loop
                RAM(i) <= std_logic_vector(to_unsigned(i, 8));
            end loop;

            QA <= (others => '0');
            QB <= (others => '0');
        elsif rising_edge(clk) then
            if WA = '1' then
                RAM(to_integer(unsigned(AddrA))) <= DataA;
	    end if;

            if WB = '1' then
                RAM(to_integer(unsigned(AddrB))) <= DataB;
            end if;

            if RA = '1' then
                QA <= RAM(to_integer(unsigned(AddrA)));
            end if;

            if RB = '1' then
                QB <= RAM(to_integer(unsigned(AddrB)));
            end if;
        end if;
    end process;
end Behavioral;