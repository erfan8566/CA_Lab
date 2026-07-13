library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cam is 
    port(
        clk, reset, rd, wr : in std_logic;
        query, mask, din : in std_logic_vector(7 downto 0);

        match : out std_logic_vector(7 downto 0);
        hit : out std_logic
    );
end cam; 

architecture behaviour of cam is 
    type mem_type is array (0 to 15) of std_logic_vector(7 downto 0); 
    signal mem : mem_type := (others => (others => '0'));
    signal dout_r : std_logic_vector(7 downto 0) := (others => '0');
    signal found_r: std_logic := '0';
begin 

    process(clk, reset)
        variable index_v : integer := 0;
        variable found_v : std_logic := '0';
    begin 
        if reset = '1' then
            for i in 0 to 15 loop 
                mem(i) <= (others => '0');
            end loop;
            dout_r  <= (others => '0');
            found_r <= '0';

        elsif rising_edge(clk) then
            found_v := '0';
            index_v := 0;

            for i in 0 to 15 loop
                if ((mask and query) = (mask and mem(i))) and (found_v = '0') then
                    index_v := i;
                    found_v := '1';
                end if;
            end loop;

            found_r <= found_v;

            if wr = '1' then
                if found_v = '1' then
                    mem(index_v) <= din;
                end if;

            elsif rd = '1' then
                if found_v = '1' then
                    dout_r <= mem(index_v);
                else
                    dout_r <= (others => '0');
                end if;

            else
                dout_r <= (others => '0');
            end if;
        end if;
    end process;

    hit <= found_r;
    match <= dout_r;

end behaviour;
