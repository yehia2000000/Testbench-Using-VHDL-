LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL ; 

PACKAGE Tb_oddP IS
COMPONENT tb_fsm IS
  PORT( clk, reset: IN std_logic;
        x: IN std_logic;
        y: OUT std_logic);
END COMPONENT tb_fsm ; 
END PACKAGE Tb_oddP ; 

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
USE WORK.Tb_oddP.ALL;

ENTITY tb_fsm_com IS
END ENTITY tb_fsm_com ; 


ARCHITECTURE behav OF tb_fsm_com IS 

FOR DUT : tb_fsm USE ENTITY WORK.fsm (mealy_3p) ;
SIGNAL d_in , clk , res : STD_LOGIC ;
SIGNAL d_out : STD_LOGIC ; 

BEGIN 
DUT :tb_fsm PORT MAP (clk,res,d_in,d_out) ;  

p1 : PROCESS IS 
BEGIN 
-- reset the clk = 0 ; 

-- reset the  design unit 
res <= '1' ;
d_in <= '0' ; 
WAIT FOR 10 ns;
ASSERT d_out = '0' 
REPORT "Problem in testing the reset pin  when d_in = 1"
SEVERITY error ; 

-- guarantee the effect of reset will not change with different input value
res <= '1' ; 
d_in <= '0' ; 
WAIT FOR 22 ns; 
ASSERT d_out = '0' 
REPORT "Problem in testing the reset pin  when d_in = 0 "
SEVERITY error ;

--Test odd Parity
res<= '0' ; 
d_in <= '1' ; 
WAIT until rising_edge(clk) ;
ASSERT d_out = '1' 
REPORT "problem Test odd Parity "
SEVERITY error;
-- Test adding zero that will not change the output
res<= '0' ; 
d_in <= '0' ; 
WAIT until rising_edge(clk) ;
ASSERT d_out = '1'
REPORT "problem Test adding zero that will not change the output"
SEVERITY error ;
-- Test odd parity 
res<= '0' ; 
d_in <= '1' ;  
WAIT until rising_edge(clk) ;
ASSERT d_out = '0'
REPORT "problem Test odd parity"
SEVERITY error ;
-- Test adding one that will change the output
res<= '0' ; 
d_in <= '1' ; 
WAIT until rising_edge(clk) ;
ASSERT d_out = '1'
REPORT "problem Test adding one that will change the output"
SEVERITY error ;

-- Test adding one that will change the output
res<= '0' ; 
d_in <= '1' ; 
WAIT until rising_edge(clk) ;
ASSERT d_out = '0'
REPORT "problem est adding one that will change the output"
SEVERITY error ;

-- Test adding zero that will not change the output 
res<= '0' ; 
d_in <= '0' ; 
WAIT until rising_edge(clk) ;
ASSERT d_out = '0'
REPORT "problem Test adding zero that will not change the output "
SEVERITY error ;

WAIT ; 
END PROCESS p1 ; 

clock: PROCESS IS
BEGIN
clk <='0', '1' AFTER 10 ns;
WAIT FOR 20 ns;
END PROCESS clock;



END ARCHITECTURE behav ; 
