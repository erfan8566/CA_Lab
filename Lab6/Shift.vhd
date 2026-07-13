library ieee;
use ieee.std_logic_1164.all;

entity shift is
  port (
    clk, reset, load : in std_logic;
    pIn : in std_logic_vector(3 downto 0);
    LR : in std_logic_vector(1 downto 0);
    reg_out : out std_logic_vector(3 downto 0)
  );
end entity shift;

architecture behavioral of shift is
  signal reg_int : std_logic_vector(3 downto 0);

begin
  process(reset, clk)
  begin
    if (reset = '1') then
	reg_int <= (others => '0');
    elsif rising_edge(clk) then
      if (load = '1') then
	 reg_int <= pIn;
      else	
	case(LR) is
	  when "00" =>
	    reg_int <= reg_int;
	  when "01" => -- SHL
	    reg_int <= reg_int(2 downto 0) & '0';
	  when "10" => -- SHR
	    reg_int <= '0' & reg_int(3 downto 1);
	  when "11" => -- SAR
	    reg_int <= reg_int(3) & reg_int(3 downto 1);
	  when others =>
	    null;
	end case;
      end if;
    end if;
  end process;
  reg_out <= reg_int;
end;