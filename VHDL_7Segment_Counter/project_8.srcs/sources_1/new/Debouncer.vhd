library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debouncer is
    Port ( Button_input: in STD_LOGIC;
           RES: in STD_LOGIC;
           CLK: in STD_LOGIC;
           X: out STD_LOGIC_VECTOR(1 downto 0));
end Debouncer;

architecture Behavioral of Debouncer is

signal SIPO_OUT: STD_LOGIC_VECTOR(7 downto 0);
signal Is_Stable: STD_LOGIC;
signal D_out: STD_LOGIC;
signal CNT_in: STD_LOGIC;

begin

    SIPO1: entity work.SIPO 
        generic map(N => 8)
        port map(I => Button_input, CLK => CLK, RES => RES, Q => SIPO_OUT);
    
    D1: entity work.D_FLIPFLOP
        port map(CLK => CLK, D => Is_Stable, RES => RES, Q => D_out);
    
    CNT2: entity work.CNT
        generic map(N => 2)
        port map(CLK => CNT_in, RES => RES, Q => X);
        
    Is_Stable <= SIPO_OUT(0) and SIPO_OUT(1) and SIPO_OUT(2) and SIPO_OUT(3) and SIPO_OUT(4) and SIPO_OUT(5) and SIPO_OUT(6) and SIPO_OUT(7);
    CNT_in <= not(D_out) and Is_Stable;
    
end Behavioral;
