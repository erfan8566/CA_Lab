library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Divider_8_4 is
end tb_Divider_8_4;

architecture Sim of tb_Divider_8_4 is

    component Divider_8_4
        port (
            clk, reset, start : in std_logic;
            Dividend : in std_logic_vector(7 downto 0);
            Divisor : in std_logic_vector(3 downto 0);
            Quotient, Remainder: out std_logic_vector(3 downto 0);
            ready, overflow : out std_logic
        );
    end component;

    signal clk_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal start_tb : std_logic := '0';
    signal Dividend_tb : std_logic_vector(7 downto 0) := (others => '0');
    signal Divisor_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal Quotient_tb : std_logic_vector(3 downto 0);
    signal Remainder_tb : std_logic_vector(3 downto 0);
    signal ready_tb : std_logic;
    signal overflow_tb : std_logic;
    
begin
    div : Divider_8_4
        port map (
            clk => clk_tb,
            reset => reset_tb,
            start => start_tb,
            Dividend => Dividend_tb,
            Divisor => Divisor_tb,
            Quotient => Quotient_tb,
            Remainder => Remainder_tb,
            ready => ready_tb,
            overflow => overflow_tb
        );

    clk_process : process
    begin
         clk_tb <= '0';
         wait for 10 ns;
         clk_tb <= '1';
         wait for 10 ns;
    end process;

    proc: process
    begin		
        reset_tb <= '1';
        start_tb <= '0';
        wait for 40 ns; 
        
        wait until rising_edge(clk_tb);
        reset_tb <= '0';
        wait for 20 ns;

        if ready_tb /= '1' then
            wait until ready_tb = '1';
        end if;
        
        wait until rising_edge(clk_tb);
        Dividend_tb <= std_logic_vector(to_unsigned(17, 8));
        Divisor_tb <= std_logic_vector(to_unsigned(3, 4));
        start_tb <= '1';
        
        wait until rising_edge(clk_tb);
        start_tb <= '0';

        wait until ready_tb = '1';
        wait for 40 ns;

        wait until rising_edge(clk_tb);
        Dividend_tb <= std_logic_vector(to_unsigned(15, 8));
        Divisor_tb <= std_logic_vector(to_unsigned(5, 4));
        start_tb <= '1';
        
        wait until rising_edge(clk_tb);
        start_tb <= '0';
        
        wait until ready_tb = '1';
        wait for 40 ns;

        wait until rising_edge(clk_tb);
        Dividend_tb <= std_logic_vector(to_unsigned(0, 8));
        Divisor_tb <= std_logic_vector(to_unsigned(7, 4));
        start_tb <= '1';
        
        wait until rising_edge(clk_tb);
        start_tb <= '0';
        
        wait until ready_tb = '1';
        wait for 40 ns;

        wait until rising_edge(clk_tb);
        Dividend_tb <= "11110000"; 
        Divisor_tb <= "0010";  
        start_tb <= '1';
        
        wait until rising_edge(clk_tb);
        start_tb <= '0';
        
        wait until ready_tb = '1';
        wait for 100 ns;

        assert false report "Simulation Finished Successfully" severity failure;
        wait;
    end process;

end Sim;
