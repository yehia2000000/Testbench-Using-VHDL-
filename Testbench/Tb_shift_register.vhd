
LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL ; 

PACKAGE Tb_Pk IS 
COMPONENT Tb_com IS 
  GENERIC( width: positive := 4);
  PORT( clk, clr, l_in, r_in, s0, s1: IN std_logic;
        d: IN std_logic_vector (width-1 DOWNTO 0);
        q: INOUT std_logic_vector (width-1 DOWNTO 0));
END COMPONENT Tb_com ; 

END PACKAGE Tb_pk ; 


LIBRARY IEEE ; 
USE IEEE.STD_LOGIC_1164.ALL ; 
USE WORK.Tb_pk.ALL ; 

ENTITY Tb_sh IS
END ENTITY Tb_sh ; 


ARCHITECTURE behav OF Tb_sh IS
FOR DUT : Tb_com USE ENTITY WORK.sr (sr) ; 

CONSTANT Width : INTEGER  := 4 ;
SIGNAL clk, clr, l_in, r_in, s0, s1 :std_logic;
SIGNAL d : std_logic_vector (width-1 DOWNTO 0);
SIGNAL q: std_logic_vector (width-1 DOWNTO 0);
BEGIN 
DUT : Tb_com GENERIC MAP (width => 4) PORT MAP ( clk, clr, l_in, r_in, s0, s1 , d ,q);

test : PROCESS IS 
BEGIN 
WAIT UNTIL falling_edge (clk); 
clr <= '0' ; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 3 ns ; 
ASSERT q = "0000" 
REPORT "Problem in effect of reset."
SEVERITY warning ; 

WAIT UNTIL falling_edge (clk); 
clr <= '1' ; 
d <= "1010" ; 
s0 <= '1' ; 
s1 <= '1' ;
WAIT UNTIL rising_edge (clk); 
WAIT FOR 3 ns ; 
ASSERT q = "1010"
REPORT "problem in  load option "
SEVERITY warning;

WAIT UNTIL falling_edge (clk); 
s0 <= '1' ; 
s1 <= '0' ;
r_in <= '0' ; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 3 ns ; 
ASSERT q = "0100"
REPORT "problem in shift left logic option "
SEVERITY warning;

WAIT UNTIL falling_edge (clk); 
s0 <= '1' ; 
s1 <= '0' ;
r_in <= '1' ; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 3 ns ; 
ASSERT q = "1001"
REPORT "problem in shift left arth option "
SEVERITY warning;

WAIT UNTIL falling_edge (clk); 
s0 <= '0' ; 
s1 <= '1' ;
l_in <= '1' ; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 3 ns ; 
ASSERT q = "1100"
REPORT "problem in shift right arth option "
SEVERITY warning;

WAIT UNTIL falling_edge (clk); 
s0 <= '0' ; 
s1 <= '1' ;
l_in <= '0' ; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 3 ns ; 
ASSERT q = "0110"
REPORT "problem in shift right logic option "
SEVERITY warning;

WAIT UNTIL falling_edge (clk); 
s0 <= '0' ; 
s1 <= '0' ;

WAIT UNTIL rising_edge (clk); 
WAIT FOR 3 ns ; 
ASSERT q = "0110"
REPORT "problem in shift right logic option "
SEVERITY warning;


WAIT  ;
END PROCESS test ; 

ck : PROCESS IS 
BEGIN 
clk <= '0' , '1' AFTER 10 ns ; 
WAIT FOR 20 ns ; 
END PROCESS ck ; 



END ARCHITECTURE behav ;