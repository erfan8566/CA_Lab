library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CPU8BIT2_tb is
end CPU8BIT2_tb;

architecture behavior of CPU8BIT2_tb is

    signal data   : std_logic_vector(7 downto 0) := (others => 'Z');
    signal adress : std_logic_vector(5 downto 0);
    signal oe     : std_logic;
    signal we     : std_logic;
    signal rst    : std_logic := '0';
    signal clk    : std_logic := '0';
    signal sim_end : boolean := false;

    type ram_type is array (0 to 63) of std_logic_vector(7 downto 0);
    signal RAM : ram_type := (
        0  => "00" & "010100",  
        1  => "10" & "010101",  
        2  => "11" & "000011",  
        3  => "00" & "110110",
        4  => "11" & "111111",  
        
        20 => x"05",            
        21 => x"02",            
        22 => x"00",            
        others => x"00"
    );

    constant clk_period : time := 10 ns;

begin

    uut: entity work.CPU8BIT2
        port map (
            data   => data,
            adress => adress,
            oe     => oe,
            we     => we,
            rst    => rst,
            clk    => clk
        );

    clk_process : process
    begin
        while not sim_end loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
        wait; 
    end process;

    ram_process : process(we, adress, data)
    begin
        if we = '0' then
            RAM(conv_integer(adress)) <= data; 
        end if;
    end process;

    data <= RAM(conv_integer(adress)) when oe = '0' else (others => 'Z');

    stim_proc: process
    begin		
        rst <= '0';
        wait for 20 ns;	
        rst <= '1'; 
        wait for 250 ns;
        sim_end <= true;
        wait;
    end process;

end behavior;
