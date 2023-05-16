library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity SIPO is
    Generic( N : integer := 8);
    Port ( I: in STD_LOGIC;
           CLK: in STD_LOGIC;
           RES: in STD_LOGIC;
           Q: out STD_LOGIC_VECTOR(N - 1 downto 0));
end SIPO;

architecture Behavioral of SIPO is
signal Value: STD_LOGIC_VECTOR(N-1 downto 0);
begin
    
    Process(CLK, RES)
    begin
        if RES = '1' then
            Value <= (others => '0');
        end if;
        if rising_edge(CLK) then
            Value(N-1) <= I;
            Value(N-2 downto 0) <= Value(N-1 downto 1);
        end if;
    end process;
    
    Q <= Value;
    
end Behavioral;
