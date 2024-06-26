LIBRARY IEEE ; 
USE IEEE.STD_LOGIC_1164.ALL ; 

PACKAGE Tb_moore_pk IS

COMPONENT Tb_moore IS
  PORT( clk, reset: IN std_logic;
        x: IN std_logic;
        y: OUT std_logic);
END COMPONENT Tb_moore; 

END PACKAGE Tb_moore_pk;

LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE WORK.Tb_moore_pk.ALL; 


ENTITY Tb_mo IS 
END ENTITY Tb_mo ; 

ARCHITECTURE behav OF Tb_mo IS

FOR DUT : Tb_moore USE ENTITY WORK.fsm (moore_2p); 

SIGNAL clk , res , d_in , d_out : STD_LOGIC ; 

BEGIN
DUT : Tb_moore PORT MAP (clk , res , d_in , d_out);
p1 : PROCESS IS

BEGIN 

-- testing the reset signal 
res <= '1' ; 
d_in <= '1' ; 
WAIT FOR 12 ns; 
ASSERT d_out = '0' 
REPORT "Problem in effect of reset signal ."
SEVERITY warning ;
WAIT UNTIL falling_edge (clk);
res <= '1' ;
d_in <= '0'  ;  
WAIT FOR 13 ns; 
ASSERT d_out = '0' 
REPORT "Problem in effect of reset signal ."
SEVERITY warning ;  
-- testing the output  


WAIT UNTIL falling_edge (clk);
--Test odd Parity
res<= '0' ; 
d_in <= '1' ; 
WAIT FOR 12 ns; 
ASSERT d_out = '1' 
REPORT "problem Test odd Parity "
SEVERITY error;
WAIT UNTIL falling_edge (clk);
-- Test adding zero that will not change the output
res<= '0' ; 
d_in <= '0' ; 
WAIT FOR 13 ns; 
ASSERT d_out = '1'
REPORT "problem Test adding zero that will not change the output"
SEVERITY error ;
WAIT UNTIL falling_edge (clk);
-- Test odd parity 
res<= '0' ; 
d_in <= '1' ;  
WAIT FOR 12 ns; 
ASSERT d_out = '0'
REPORT "problem Test odd parity"
SEVERITY error ;
WAIT UNTIL falling_edge (clk);
-- Test adding one that will change the output
res<= '0' ; 
d_in <= '1' ; 
WAIT FOR 13 ns; 
ASSERT d_out = '1'
REPORT "problem Test adding one that will change the output"
SEVERITY error ;
WAIT UNTIL falling_edge (clk);
-- Test adding one that will change the output
res<= '0' ; 
d_in <= '1' ; 
WAIT FOR 13 ns; 
ASSERT d_out = '0'
REPORT "problem est adding one that will change the output"
SEVERITY error ;
WAIT UNTIL falling_edge (clk);
-- Test adding zero that will not change the output 
res<= '0' ; 
d_in <= '0' ; 
WAIT FOR 13 ns; 
ASSERT d_out = '0'
REPORT "problem Test adding zero that will not change the output "
SEVERITY error ;

WAIT ; 
END PROCESS p1 ; 

ck : PROCESS IS
BEGIN 
clk <= '0' , '1' AFTER 10 ns ; 
WAIT FOR 20 ns ; 
END PROCESS ck ; 



END ARCHITECTURE behav ; 