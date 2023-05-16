library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity D_FLIPFLOP is
    Port ( CLK: in STD_LOGIC;
           D: in STD_LOGIC;
           Q: out STD_LOGIC;
           RES: in STD_LOGIC);
end D_FLIPFLOP;

architecture Behavioral of D_FLIPFLOP is

begin
    Process( CLK, RES )
    begin
        if rising_edge(CLK) then
            Q <= D;
        end if;
        
        if RES = '1' then
            Q <= '0';
        end if;
    end Process;
end Behavioral;
