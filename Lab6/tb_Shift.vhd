library ieee;
use ieee.std_logic_1164.all;

entity shift_tb is
end entity shift_tb;

architecture test of shift_tb is
  component shift is
    port (
      clk, reset, load : in std_logic;
      pIn : in std_logic_vector(3 downto 0);
      LR : in std_logic_vector(1 downto 0);
      reg_out : out std_logic_vector(3 downto 0)
  );
  end component;

  signal clk, reset, load : std_logic;
  signal pIn : std_logic_vector(3 downto 0);
  signal LR : std_logic_vector(1 downto 0);
  signal reg_out : std_logic_vector(3 downto 0);
  
begin
  m1: shift port map (clk => clk, reset => reset, load => load, pIn => pIn, LR => LR, reg_out => reg_out);

  clk_process: process
  begin
    clk <= '0';
    wait for 10ns;
    clk <= '1';
    wait for 10ns;
  end process;

  p: process
   begin
    reset <= '1';
    pIn <= "1010";
    LR <= "00";
    load <= '0';
    wait for 20ns;

    reset <= '0';
    load <= '1';
    wait for 20ns;

    load <= '0';
    LR <= "00";
    wait for 20ns;

    LR <= "01";
    wait for 20ns;

    LR <= "10";
    wait for 20ns;

    LR <= "11";
    wait for 20ns;
    
    assert false report "Simulation finished" severity failure;
  end process;
end test;
