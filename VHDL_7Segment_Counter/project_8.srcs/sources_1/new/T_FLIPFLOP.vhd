library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity T_FLIPFLOP is
    Port ( CLK: in STD_LOGIC;
           T: in STD_LOGIC;
           Q: out STD_LOGIC;
           RES: in STD_LOGIC);
end T_FLIPFLOP;

architecture Behavioral of T_FLIPFLOP is
signal temp: STD_LOGIC;
begin

    Process(CLK, RES)
    begin
        if RES = '1' then
            temp <= '0';
        end if;
        if rising_edge(CLK) then
            if T = '0' then
                temp <= temp;
            elsif T = '1' then
                temp <= not temp;
            end if;
        end if;
    end Process;
    
    Q <= temp;


end Behavioral;
