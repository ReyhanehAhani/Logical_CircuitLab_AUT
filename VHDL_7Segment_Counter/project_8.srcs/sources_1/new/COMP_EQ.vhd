library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity COMP_EQ is
    Generic( N : integer := 8);
    Port ( A: in STD_LOGIC_VECTOR(N-1 downto 0);
           B: in STD_LOGIC_VECTOR(N-1 downto 0);
           S: out STD_LOGIC);
end COMP_EQ;

architecture Behavioral of COMP_EQ is

begin

S <= '1' when A = B else '0';

end Behavioral;
