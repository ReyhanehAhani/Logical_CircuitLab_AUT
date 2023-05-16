library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity MUX4_1 is
    Port ( I0: in STD_LOGIC;
           I1: in STD_LOGIC;
           I2: in STD_LOGIC;
           I3: in STD_LOGIC;
           S: in STD_LOGIC_VECTOR(1 downto 0);
           Q: out STD_LOGIC);
end MUX4_1;

architecture Behavioral of MUX4_1 is

begin

    with S select Q <=
        I0 when "00",
        I1 when "01",
        I2 when "10",
        I3 when "11";

end Behavioral;
