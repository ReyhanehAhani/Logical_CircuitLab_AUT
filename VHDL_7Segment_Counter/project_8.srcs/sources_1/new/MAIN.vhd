library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAIN is
    Port ( Unlock: in STD_LOGIC;
           Button_input: in STD_LOGIC;
           RESET: in STD_LOGIC;
           CLK: in STD_LOGIC;
           Y: out STD_LOGIC;
           Si: in STD_LOGIC;
           DataCLK: in STD_LOGIC);
end MAIN;

architecture Behavioral of MAIN is
signal RES: STD_LOGIC;
signal dClock: STD_LOGIC;
signal mOut: STD_LOGIC;
signal mOut2: STD_LOGIC;
signal k: STD_LOGIC;
signal rRES: STD_LOGIC;
signal tRES: STD_LOGIC;
signal compResult: STD_LOGIC;

signal dOut: STD_LOGIC_VECTOR(23 downto 0);
signal cntOut: STD_LOGIC_VECTOR(15 downto 0);
signal sipoOut: STD_LOGIC_VECTOR(15 downto 0);
signal X: STD_LOGIC_VECTOR(1 downto 0);
begin

    RES <= not(RESET);
    dClock <= dOut(15);
    rRES <= RES or compResult;
    tRES <= RES or Unlock;
    Y <= k;
    
    CNT24: entity work.CNT
           Generic map(N => 24)
           Port map(CLK => CLK, RES => RES, Q => dOut);
    
    Debouncer1: entity work.Debouncer
                Port map(Button_input => Button_input, RES => RES, CLK => dClock, X => X);

    MUX41: entity work.MUX4_1
           Port map(Q => mOut,I0 => dOut(10), I1 => dOut(11), I2 => dOut(12), I3 => dOut(13), S => X);
    
    MUX21: entity work.MUX2_1
           Port map(I0 => mOut, I1 => '0', S => k, Q => mOut2);
    
    CNT16: entity work.CNT
           Generic map(N => 16)
           Port map(CLK => mOut2, RES => rRES, Q => cntOut);
    
    SIPO1: entity work.SIPO
           Generic map(N => 16)
           Port map(CLK => DataCLK, I => Si, RES => RES, Q => sipoOut);
    
    COMP: entity work.COMP_EQ
          Generic map(N => 16)
          Port map(A => cntOut, B => sipoOut, S => compResult);
    
    T_FLIP_FLOP: entity work.T_FLIPFLOP
                 Port map(T => '1', CLK => compResult, RES => tRES, Q => k);
    
      
end Behavioral;
