library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CPU8BIT2 is
    port ( 
        data   : inout std_logic_vector(7 downto 0);
        adress : out std_logic_vector(5 downto 0);
        oe     : out std_logic;
        we     : out std_logic;
        rst    : in std_logic;
        clk    : in std_logic
    );
end CPU8BIT2;

architecture CPU_ARCH of CPU8BIT2 is
    signal akku   : std_logic_vector(7 downto 0);
    signal c_flag : std_logic;
    signal adreg  : std_logic_vector(5 downto 0);
    signal pc     : std_logic_vector(5 downto 0);
    signal ir     : std_logic_vector(7 downto 0);
    
    type state_type is (S_FETCH, S_DECODE, S_EXECUTE, S_WRITEBACK, S_HALT);
    signal states : state_type;
    
begin

    process(clk, rst)
        variable temp_add : std_logic_vector(8 downto 0);
        variable temp_sub : std_logic_vector(8 downto 0);
    begin
        if (rst = '0') then
            adreg   <= (others => '0');
            pc      <= (others => '0');
            akku    <= (others => '0');
            ir      <= (others => '0');
            c_flag  <= '0';
            states  <= S_FETCH;
            
        elsif rising_edge(clk) then
            case states is
                
                when S_FETCH =>
                    adreg  <= pc;
                    states <= S_DECODE;
                    
                when S_DECODE =>
                    ir   <= data;
                    pc   <= pc + 1;
                    
                    if data(7 downto 5) = "111" and data(4 downto 3) /= "11" then
                        adreg <= "000" & data(2 downto 0);
                    else
                        adreg <= "0" & data(4 downto 0);
                    end if;
                    
                    states <= S_EXECUTE;
                    
                when S_EXECUTE =>
                    case ir(7 downto 5) is
                        
                        when "000" => -- Load
                            akku   <= data;
                            states <= S_FETCH;
                            
                        when "001" => -- Store
                            states <= S_WRITEBACK;
                            
                        when "010" => -- Brz
                            if akku = x"00" then pc <= "0" & ir(4 downto 0); end if;
                            adreg  <= pc;
                            states <= S_FETCH;
                            
                        when "011" => -- Brnz
                            if akku /= x"00" then pc <= "0" & ir(4 downto 0); end if;
                            adreg  <= pc;
                            states <= S_FETCH;
                            
                        when "100" => -- Add
                            temp_add := ("0" & akku) + ("0" & data);
                            akku     <= temp_add(7 downto 0);
                            c_flag   <= temp_add(8);
                            adreg    <= pc;
                            states   <= S_FETCH;
                            
                        when "101" => -- Sub
                            temp_sub := ("0" & akku) - ("0" & data);
                            akku     <= temp_sub(7 downto 0);
                            c_flag   <= temp_sub(8);
                            adreg    <= pc;
                            states   <= S_FETCH;
                            
                        when "110" =>
                            case ir(4 downto 0) is
                                when "00000" => -- Ror
                                    akku   <= akku(0) & akku(7 downto 1);
                                    c_flag <= akku(0);
                                when "00001" => -- Rol
                                    akku   <= akku(6 downto 0) & akku(7);
                                    c_flag <= akku(7);
                                when "00010" => -- Shr
                                    c_flag <= akku(0);
                                    akku   <= '0' & akku(7 downto 1);
                                when "00011" => -- Shl
                                    c_flag <= akku(7);
                                    akku   <= akku(6 downto 0) & '0';
                                when "00100" => -- Not
                                    akku   <= not akku;
                                when "00101" => -- Show
                                    null; 
                                when others => 
                                    null;
                            end case;
                            adreg  <= pc;
                            states <= S_FETCH;
                            
                        when "111" =>
                            case ir(4 downto 3) is
                                when "00" => -- AND
                                    akku   <= akku and data;
                                    adreg  <= pc;
                                    states <= S_FETCH;
                                    
                                when "01" => -- OR
                                    akku   <= akku or data;
                                    adreg  <= pc;
                                    states <= S_FETCH;
                                    
                                when "10" => -- XOR
                                    akku   <= akku xor data;
                                    adreg  <= pc;
                                    states <= S_FETCH;
                                    
                                when "11" => -- HALT
                                    states <= S_HALT;
                                    
                                when others =>
                                    adreg  <= pc;
                                    states <= S_FETCH;
                            end case;

                        when others =>
                            adreg  <= pc;
                            states <= S_FETCH;
                    end case;

                when S_WRITEBACK =>
                    adreg  <= pc; 
                    states <= S_FETCH;
                    
                when S_HALT =>
                    states <= S_HALT;
                    
            end case;
        end if;
    end process;

    adress <= "0" & ir(4 downto 0) when (states = S_WRITEBACK or (states = S_EXECUTE and ir(7 downto 5) = "001")) else adreg;
    
    data   <= akku when (states = S_WRITEBACK or (states = S_EXECUTE and ir(7 downto 5) = "001")) else (others => 'Z');
    
    oe     <= '0' when (states = S_DECODE or 
                         (states = S_EXECUTE and (ir(7 downto 5) = "100" or 
                                                  ir(7 downto 5) = "101" or 
                                                  ir(7 downto 5) = "000" or
                                                  (ir(7 downto 5) = "111" and ir(4 downto 3) /= "11")))) 
              else '1';
    
    we     <= '0' when (states = S_WRITEBACK or (states = S_EXECUTE and ir(7 downto 5) = "001")) else '1';

end CPU_ARCH;