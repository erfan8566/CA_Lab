library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ROM16x8 is
end tb_ROM16x8;

architecture test of tb_ROM16x8 is
    component ROM16x8 is
        port (
            Addr : in  std_logic_vector(3 downto 0);
            Q    : out std_logic_vector(7 downto 0)
        );
    end component;

    signal Addr : std_logic_vector(3 downto 0) := (others => '0');
    signal Q    : std_logic_vector(7 downto 0);
begin
    rom : ROM16x8
        port map (
            Addr => Addr,
            Q    => Q
        );

    stim_proc : process
    begin
        Addr <= "0000";
        wait for 10 ns;

        Addr <= "0001";
        wait for 10 ns;

        Addr <= "0011";
        wait for 10 ns;

        Addr <= "0101";
        wait for 10 ns;

        Addr <= "1010";
        wait for 10 ns;

        Addr <= "1111";
        wait for 10 ns;

        assert false report "Simulation Finished" severity failure;
    end process;
end test;
