library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_booth_fsm is
-- ??????? ???? ?????/????? ?????
end tb_booth_fsm;

architecture Behavioral of tb_booth_fsm is

    -- ????? ???????? ???? ???? (DUT)
    component booth_fsm
        Port ( 
            clk   : in  STD_LOGIC;
            rst   : in  STD_LOGIC;
            start : in  STD_LOGIC;
            A     : in  STD_LOGIC_VECTOR (3 downto 0);
            B     : in  STD_LOGIC_VECTOR (3 downto 0);
            Z     : out STD_LOGIC_VECTOR (7 downto 0);
            ready : out STD_LOGIC
        );
    end component;

    -- ?????????? ????? ???? ????? ?? ????????
    signal clk   : std_logic := '0';
    signal rst   : std_logic := '0';
    signal start : std_logic := '0';
    signal A     : std_logic_vector(3 downto 0) := (others => '0');
    signal B     : std_logic_vector(3 downto 0) := (others => '0');
    signal Z     : std_logic_vector(7 downto 0);
    signal ready : std_logic;

    -- ????? ???? ????? ????
    constant clk_period : time := 10 ns;

begin

    -- ?????????? ?? ????? ?????????
    uut: booth_fsm Port map (
        clk   => clk,
        rst   => rst,
        start => start,
        A     => A,
        B     => B,
        Z     => Z,
        ready => ready
    );

    -- ????? ????? ????
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- ????? ????? ???????? (Stimulus)
    stim_proc: process
    begin
        -- ???? ????? ????
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 10 ns;

        -- ??? ?: $3 \times 2 = 6$
        A <= std_logic_vector(to_signed(3, 4));
        B <= std_logic_vector(to_signed(2, 4));
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until ready = '1'; -- ?????? ???? ????? ??????
        wait for clk_period;

        -- ??? ?: $-3 \times 2 = -6$
        A <= std_logic_vector(to_signed(-3, 4));
        B <= std_logic_vector(to_signed(2, 4));
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until ready = '1';
        wait for clk_period;

        -- ??? ?: $3 \times -2 = -6$
        A <= std_logic_vector(to_signed(3, 4));
        B <= std_logic_vector(to_signed(-2, 4));
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until ready = '1';
        wait for clk_period;

        -- ??? ?: $-4 \times -3 = 12$
        A <= std_logic_vector(to_signed(-4, 4));
        B <= std_logic_vector(to_signed(-3, 4));
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until ready = '1';
        wait for clk_period;

        -- ??? ?: ???????? ??? ???? $-8 \times -8 = 64$
        A <= std_logic_vector(to_signed(-8, 4));
        B <= std_logic_vector(to_signed(-8, 4));
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until ready = '1';
        wait for clk_period;

        -- ????? ?????????
        report "Simulation finished successfully";
	wait;
    end process;

end Behavioral;
