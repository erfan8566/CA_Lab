library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Divider_8_4 is
    port (
        clk, reset, start : in std_logic;
        Dividend : in std_logic_vector(7 downto 0); -- R:A
        Divisor : in std_logic_vector(3 downto 0); -- B
        Quotient, Remainder : out std_logic_vector(3 downto 0); -- A and R
        ready, overflow : out std_logic
    );
end Divider_8_4;

architecture Behavioral of Divider_8_4 is

    type state_type is (IDLE, CHECK_OVERFLOW, SHIFT_SUB, DRAW_BITS, DECR_SC, DONE);
    signal current_state, next_state : state_type;

    signal R_reg, R_next : unsigned(3 downto 0);
    signal A_reg, A_next : unsigned(3 downto 0);
    signal B_reg, B_next : unsigned(3 downto 0);
    
    signal E_reg, E_next : std_logic;
    signal sc_reg, sc_next : integer range 0 to 4;
    signal ovf_reg, ovf_next : std_logic;

begin
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= IDLE;
            R_reg <= (others => '0');
            A_reg <= (others => '0');
            B_reg <= (others => '0');
            E_reg <= '0';
            sc_reg <= 0;
            ovf_reg <= '0';
        elsif rising_edge(clk) then
            current_state <= next_state;
            R_reg <= R_next;
            A_reg <= A_next;
            B_reg <= B_next;
            E_reg <= E_next;
            sc_reg <= sc_next;
            ovf_reg <= ovf_next;
        end if;
    end process;

    process(current_state, start, Dividend, Divisor, R_reg, A_reg, B_reg, E_reg, sc_reg, ovf_reg)
        variable shift_buffer : unsigned(8 downto 0); -- E:R:A
        variable sub_res : unsigned(4 downto 0);
    begin
        next_state <= current_state;
        R_next <= R_reg;
        A_next <= A_reg;
        B_next <= B_reg;
        E_next <= E_reg;
        sc_next <= sc_reg;
        ovf_next <= ovf_reg;
        ready <= '0';

        case current_state is
            when IDLE =>
                ready <= '1';
                if start = '1' then
                    R_next <= unsigned(Dividend(7 downto 4));
                    A_next <= unsigned(Dividend(3 downto 0));
                    B_next <= unsigned(Divisor);
                    E_next <= '0';
                    sc_next <= 4;
                    ovf_next <= '0';
                    next_state <= CHECK_OVERFLOW;
                end if;

            when CHECK_OVERFLOW =>
                if R_reg >= B_reg then
                    ovf_next <= '1';
                    next_state <= DONE;
                else
                    ovf_next <= '0';
                    next_state <= SHIFT_SUB;
                end if;

            when SHIFT_SUB =>
                shift_buffer := E_reg & R_reg & A_reg;
                shift_buffer := shift_left(shift_buffer, 1);
                
                sub_res := ('0' & shift_buffer(7 downto 4)) - unsigned('0' & B_reg);
                
                E_next <= not sub_res(4); -- C out = not B out
                R_next <= sub_res(3 downto 0);
                A_next <= shift_buffer(3 downto 0);  
                next_state <= DRAW_BITS;

            when DRAW_BITS =>
                if E_reg = '0' then
                    R_next <= R_reg + B_reg;
                    A_next(0) <= '0';
                else
                    A_next(0) <= '1'; 
                end if;
                next_state <= DECR_SC;

            when DECR_SC =>
                if sc_reg = 1 then
                    next_state <= DONE;
                else
                    sc_next <= sc_reg - 1;
                    next_state <= SHIFT_SUB;
                end if;

            when DONE =>
                ready <= '1';
                if start = '0' then
                    next_state <= IDLE;
                end if;

            when others =>
                next_state <= IDLE;
        end case;
    end process;

    Quotient <= std_logic_vector(A_reg);
    Remainder <= std_logic_vector(R_reg);
    overflow <= ovf_reg;

end Behavioral;
