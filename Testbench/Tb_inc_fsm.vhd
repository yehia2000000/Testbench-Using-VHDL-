
LIBRARY IEEE ; 
USE IEEE.STD_LOGIC_1164.ALL; 
PACKAGE Tb_PACK IS
COMPONENT tb_com IS
  PORT( u, d, reset: IN bit;
        clk: IN std_logic;
        inc, dec, c: OUT bit);   
END COMPONENT tb_com ; 
END PACKAGE Tb_PACK ; 


LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL ; 
USE WORK.Tb_PACK.ALL ; 

ENTITY tb_inc IS
END ENTITY tb_inc ; 

ARCHITECTURE behav OF tb_inc IS 
FOR DUT : tb_com USE ENTITY WORK.source (fsm) ; 
type Tb_state IS (RES_S , INC_S , DEC_S , CLR_S , SET_S ,FIN_S );
SIGNAL u , d , reset : BIT ; 
SIGNAL clk : STD_LOGIC  ;
SIGNAL inc , dec , c : BIT ; 

SIGNAL T_st : Tb_state := RES_S; 

BEGIN 
---------------------------------------DUT instance ---------------------------
DUT : tb_com PORT MAP (u , d, reset , clk , inc , dec ,c ); 
--------------------------------------------------------------------------------
-------------------------------------test strategy------------------------------
test : PROCESS IS 
VARIABLE current_state : natural RANGE 0 TO 1   := 0 ; 
VARIABLE flag : natural RANGE 0 TO 1 := 0  ;
BEGIN 

CASE T_st IS 
	WHEN RES_S => 
		WAIT UNTIL falling_edge (clk) ; 
		reset <= '1' ; 
		u <= '0' ; 
		d <= '0' ; 
		WAIT UNTIL rising_edge (clk) ; 
		WAIT FOR 2 ns ; 
		ASSERT c = '0' and inc = '0'  and dec ='0' 
		REPORT "Problem in reset implementation and effect on the output"
		SEVERITY warning ; 
		current_state := 0 ; 
		T_st <= INC_S ; 
		WAIT FOR 2 ns ; 
	WHEN INC_S => 
		WAIT UNTIL falling_edge (clk); 
		reset <= '0' ; 
		u<= '1' ; 
		d<= '0' ; 
		WAIT UNTIL rising_edge (clk); 
		WAIT FOR 2 ns ; 
		ASSERT c ='1' and inc = '0'  and dec ='0'
		REPORT "Problem in increment implementation and effect on the output"
		SEVERITY warning ; 
		current_state := 1 ; 
		T_st <= DEC_S ; 
		WAIT FOR 2 ns ; 
	WHEN DEC_S => 
		WAIT UNTIL falling_edge (clk); 
		reset <= '0' ; 
		u<= '0' ; 
		d<= '1' ; 
		WAIT UNTIL rising_edge (clk); 
		WAIT FOR 2 ns ; 
		ASSERT c ='0' and inc = '0' and dec ='0'
		REPORT "Problem in decrement implementation and effect on the output"
		SEVERITY warning ; 
		current_state := 0 ; 
		T_st <= CLR_S ; 
		WAIT FOR 2 ns ; 
	WHEN CLR_S => 
		WAIT UNTIL falling_edge (clk); 
		reset <= '0' ; 
		u<= '0' ; 
		d<= '0' ; 
		WAIT UNTIL rising_edge (clk);
		WAIT FOR 2 ns ; 
		IF current_state = 0 THEN 
			ASSERT c ='0' and inc = '0'  and dec ='0' 
			REPORT "Problem in clear implementation and effect on the output"
			SEVERITY warning ; 
			current_state := 0 ; 
		ELSE  
			ASSERT c ='1' and inc = '1'  and dec ='0' 
			REPORT "Problem in clear implementation and effect on the output"
			SEVERITY warning ;
			current_state := 0 ; 
		END IF ; 
		T_st <= SET_S ; 
		WAIT FOR 2 ns ; 

	WHEN SET_S => 
		WAIT UNTIL falling_edge (clk); 
		reset <= '0' ; 
		u<= '1' ; 
		d<= '1' ; 
		WAIT UNTIL rising_edge (clk); 
		WAIT FOR 2 ns ; 
		IF current_state = 0 THEN
			ASSERT c ='1' and inc = '0'  and dec ='1' 
			REPORT "Problem in set implementation and effect on the output"
			SEVERITY warning ; 
			current_state := 1 ; 
		ELSE 
			ASSERT c ='0' and inc = '1'  and dec ='0' 
			REPORT "Problem in set implementation and effect on the output"
			SEVERITY warning ; 
			current_state := 0 ; 
		END IF ; 
		IF flag = 0  THEN 
		T_st <= SET_S ;
		flag := 1 ;
		ELSE 
		T_st <= FIN_S ; 
		END IF ;  
		WAIT FOR 2 ns ; 
	WHEN FIN_S => 
		WAIT ; 
	END CASE ; 
		
END PROCESS test ; 
-------------------------------------------------------------------------------
------------------------clock generation --------------------------------------
ck : PROCESS IS
BEGIN 
clk <= '0' , '1' AFTER 10 ns; 
WAIT FOR 20 ns ; 
END PROCESS ck ; 
-------------------------------------------------------------------------------

END ARCHITECTURE behav; 

