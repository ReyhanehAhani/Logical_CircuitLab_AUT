library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity MUX2_1 is
    Port ( I0: in STD_LOGIC;
           I1: in STD_LOGIC;
           S: in STD_LOGIC;
           Q: out STD_LOGIC);
end MUX2_1;

architecture Behavioral of MUX2_1 is

begin

    with S select Q <=
        I0 when '0',
        I1 when '1';

end Behavioral;