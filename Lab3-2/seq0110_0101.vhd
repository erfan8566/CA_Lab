library ieee;
use ieee.std_logic_1164.all;

entity seq_dec is
   port (
     input, clk: in std_logic;
     output: out std_logic
);
end entity seq_dec;

architecture behavioral of seq_dec is
   type states is (s0, s1, s2, s3, s4, s5, s6);
   signal state : states := s0;
   signal next_state : states := s0;

begin
   REG : process(clk) begin
      if(clk'event and clk = '1') then
	state <= next_state;
      end if;
   end process;

   CMB : process(state, input) begin
       case state is
	 when s0 =>
	    if (input = '0') then
		next_state <= s1;
	    else
		next_state <= s0;
	    end if;

	 when s1 =>
	    if (input = '0') then
		next_state <= s1;
	    else
		next_state <= s2;
	    end if;

	  when s2 =>
	    if (input = '0') then
		next_state <= s3;
	    else
		next_state <= s5;
	    end if;

	  when s3 =>
	    if (input = '0') then
		next_state <= s1;
	    else
		next_state <= s4;
	    end if;

	  when s4 =>
	    if (input = '0') then
		next_state <= s1;
	    else
		next_state <= s0;
	    end if;

	  when s5 =>
	    if (input = '0') then
		next_state <= s6;
	    else
		next_state <= s0;
	    end if;

	  when s6 =>
	    if (input = '0') then
		next_state <= s1;
	    else
		next_state <= s2;
	    end if;
       end case;
   end process;

   with state select
   output <= '1' when s4,
	     '1' when s6,
	     '0' when others;
end behavioral;
