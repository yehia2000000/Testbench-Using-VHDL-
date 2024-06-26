
LIBRARY IEEE ; 
USE IEEE.STD_LOGIC_1164.ALL ; 
USE IEEE.NUMERIC_STD.ALL ; 

PACKAGE Tb_pk IS 
COMPONENT Tb_com IS 
  GENERIC( n: positive := 4);
  PORT( clk, clear, up_down: IN std_logic;
        preset: IN std_logic;
        d_in: IN unsigned (n-1 DOWNTO 0);
        d_out: OUT unsigned (n-1 DOWNTO 0));
END COMPONENT Tb_com  ; 
END PACKAGE Tb_pk ;

LIBRARY IEEE ; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL; 
USE WORK. Tb_pk.ALL ;

ENTITY Tb_co IS 
END ENTITY Tb_co ; 

ARCHITECTURE behav OF Tb_co IS 
CONSTANT n : positive :=4 ; 

FOR DUT : Tb_com USE ENTITY WORK.bin_counter (behav); 
SIGNAL clk, clear, up_down , preset : std_logic;
SIGNAL d_in , d_out : unsigned (n-1 DOWNTO 0) ;

BEGIN
DUT : Tb_com GENERIC MAP (n=>4) PORT MAP (clk, clear, up_down , preset ,  d_in , d_out);

test : PROCESS IS 
VARIABLE c : positive :=2 ; 
BEGIN 
--------------------------------------------------  reset -------------------------------------------------
WAIT UNTIL falling_edge (clk) ; 
clear <= '1'; 	
WAIT UNTIL rising_edge (clk) ;
WAIT FOR 4 ns ; 
ASSERT d_out = "0000" 
REPORT "problem in reset effect on the output"
SEVERITY warning ; 

--------------------------------------------------  preset -------------------------------------------------
WAIT UNTIL falling_edge (clk) ; 
clear <= '0' ;
preset <= '1'; 
d_in <= "1010";
WAIT UNTIL rising_edge (clk) ;
WAIT FOR 4 ns ; 
ASSERT d_out = "1010"
REPORT "problem in preset option ."
SEVERITY warning ; 

--------------------------------------------------  count up (2) cycle  -------------------------------------------------
WAIT UNTIL falling_edge (clk) ; 
clear <= '0' ;
preset <= '0'; 
up_down <= '1' ; 
FOR j IN c-1 DOWNTO 0 LOOP
	WAIT UNTIL rising_edge (clk) ;
END LOOP ;
WAIT FOR 4 ns ; 
ASSERT d_out = "1100"
REPORT "problem in count up (2) cycle option ."
SEVERITY warning ; 

--------------------------------------------------  count down (3) -------------------------------------------------
WAIT UNTIL falling_edge (clk) ; 
clear <= '0' ;
preset <= '0'; 
up_down <= '0' ; 
FOR j IN c DOWNTO 0 LOOP
	WAIT UNTIL rising_edge (clk) ;
END LOOP ; 
WAIT FOR 4 ns ; 
ASSERT d_out = "1001"
REPORT "problem in count down (3) cycle option ."
SEVERITY warning ; 

--------------------------------------------------  count down to min  -------------------------------------------------
WAIT UNTIL falling_edge (clk) ; 
clear <= '0' ;
preset <= '0'; 
up_down <= '0' ; 
 FOR j IN to_integer(d_out) DOWNTO 0 LOOP
	WAIT UNTIL rising_edge (clk) ;
END LOOP ; 
WAIT FOR 4 ns ; 
ASSERT d_out = "1111"
REPORT "problem in count down to min option ."
SEVERITY warning ; 

--------------------------------------------------  count up to max  -------------------------------------------------
WAIT UNTIL falling_edge (clk) ; 
clear <= '0' ;
preset <= '0'; 
up_down <= '0' ; 
 FOR j IN 0 TO to_integer(d_out)-1 LOOP
	WAIT UNTIL rising_edge (clk) ;
END LOOP ; 
WAIT FOR 4 ns ; 
ASSERT d_out = "0000"
REPORT "problem in count up to max option ."
SEVERITY warning ; 

WAIT  ;
END PROCESS test ; 

ck : PROCESS IS 
BEGIN 
clk <= '0' , '1' AFTER 10 ns ; 
WAIT FOR 20 ns ; 
END PROCESS ck ; 

END ARCHITECTURE behav ;  
