LIBRARY IEEE ; 
USE IEEE.STD_LOGIC_1164.ALL; 

PACKAGE Tb_pk IS 
COMPONENT Tb_com IS 
PORT( cw, ccw, reset, clk: IN std_logic;
angle : OUT std_logic_vector (2 DOWNTO 0));
END COMPONENT Tb_com ; 
END PACKAGE Tb_pk ; 

LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL ; 
USE work.const_johnson_encoding.ALL;
USE WORK.Tb_pk.ALL ; 


ENTITY tb_jo IS
END ENTITY tb_jo ; 


ARCHITECTURE behav OF tb_jo IS 
FOR DUT : Tb_com USE ENTITY WORK.angle (angle); 
SIGNAL  cw, ccw, reset, clk : std_logic;
SIGNAL angle : std_logic_vector (2 DOWNTO 0);

BEGIN 
DUT : Tb_com PORT MAP (cw, ccw, reset, clk ,angle );
test : PROCESS IS 
BEGIN 
--------------------------------------------------------------------------------------
----------------------------------------rst =1 -------------------------------------
reset <= '1' ; 
cw <= '0' ; 
ccw <= '1' ;WAIT UNTIL rising_edge (clk); 
WAIT FOR 2 ns  ; 
ASSERT angle = "0000" 
REPORT "Problem in effect the reset on outputs."
SEVERITY warning ;
------------------------------------------------------------------------------------
------------------------------rst =1 -----------------------------------------------
WAIT UNTIL falling_edge (clk); 
reset <= '1';
cw <= '0' ; 
ccw <= '1' ; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 2 ns  ; 
ASSERT angle = "0000"
REPORT "Problem in effect the reset on the outputs"
SEVERITY warning ; 
-------------------------------------------------------------------------------------
-----------------------------------cw = 1 , ccw =0 ----------------------------------
WAIT UNTIL falling_edge (clk) ; 
reset <= '0' ; 
cw <= '1' ;
ccw <=  '0'; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 2 ns  ; 
ASSERT angle  = "0001"
REPORT "problem in clock wise transition "
SEVERITY warning ; 
------------------------------------------------------------------------------------
--------------------------------cw = 0 , ccw = 0 -----------------------------------
WAIT UNTIL falling_edge (clk); 
reset <= '0' ; 
cw <= '0' ;
ccw <=  '0'; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 2 ns  ; 
ASSERT angle = "0001"
REPORT "problem in staying the state"
SEVERITY warning ; 
-------------------------------------------------------------------------------------
---------------------------------- cw = 0 , ccw = 1 ---------------------------------
WAIT UNTIL falling_edge (clk); 
reset <= '0' ; 
cw <= '0' ;
ccw <=  '1'; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 2 ns  ; 
ASSERT angle = "0000" 
REPORT "problem in counterclockwise the state"
SEVERITY warning ; 
-------------------------------------------------------------------------------------
------------------------------ cw = 1 , ccw = 1 -------------------------------------
WAIT UNTIL falling_edge (clk); 
reset <= '0' ; 
cw <= '1' ;
ccw <=  '1'; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 2 ns  ; 
ASSERT angle = "0000"
REPORT "problem in staying state in confilct cw , ccw "
SEVERITY warning ; 
---------------------------------------------------------------------------------------
------------------------------ cw = 0 , ccw = 1 ---------------------------------------
WAIT UNTIL falling_edge (clk); 
reset <= '0' ; 
cw <= '0' ;
ccw <=  '1'; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 2 ns  ; 
ASSERT angle = "1000" 
REPORT "problem in counterclockwise the state"
SEVERITY warning ; 
---------------------------------------------------------------------------------------
------------------------------cw = 1 , ccw = 0 ----------------------------------------
WAIT UNTIL falling_edge (clk); 
reset <= '0' ; 
cw <= '1' ;
ccw <=  '0'; 
WAIT UNTIL rising_edge (clk); 
WAIT FOR 2 ns  ; 
ASSERT angle = "1000" 
REPORT "problem in clockwise the state"
SEVERITY warning ; 
---------------------------------------------------------------------------------------
WAIT ;
END PROCESS test ; 



ck : PROCESS IS 
BEGIN 
clk <= '0' , '1' AFTER 10 ns ; 
WAIT FOR 20 ns; 
END PROCESS ck ; 



END ARCHITECTURE behav ; 

