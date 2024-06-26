

LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL ; 

PACKAGE Tb_comp IS
COMPONENT  comparator IS
   Port( a : IN  std_logic_vector (7 DOWNTO 0);
         b: IN std_logic_vector (7 DOWNTO 0);
         equal_out : OUT std_logic;
         not_equal_out: OUT std_logic);
END COMPONENT comparator ; 
END PACKAGE Tb_comp ; 

LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL ; 
USE WORK.Tb_comp.ALL ; 

ENTITY Tb_Comparator IS
END ENTITY Tb_Comparator ; 


ARCHITECTURE behav OF Tb_Comparator IS 

For dut : comparator USE ENTITY WORK.comparator(Behavioral);
SIGNAL d_in1 : STD_LOGIC_VECTOR (7 DOWNTO 0 ); 
SIGNAL d_in2 : STD_LOGIC_VECTOR ( 7 DOWNTO 0 ); 
SIGNAL d_eq :STD_LOGIC ; 
SIGNAL d_neq : STD_LOGIC ; 

BEGIN 
dut : comparator PORT MAP ( d_in1 , d_in2 , d_eq , d_neq) ; 

P1 : PROCESS IS

BEGIN 

d_in1 <= "00000000" ; 
d_in2 <= "00000000" ; 
WAIT FOR 15 ns ; 
ASSERT d_eq = '1' and d_neq = '0' 
REPORT "Problem with Equality at zero"
SEVERITY error ;

d_in1 <= "11110000" ; 
d_in2 <= "10100000" ; 
WAIT FOR 15 ns ;
ASSERT d_eq = '0' and d_neq = '1'
REPORT "Problem with equality at lsb"
SEVERITY error ;
 

d_in1 <= "00001011" ; 
d_in2 <= "00000000" ; 
WAIT FOR 15 ns ; 
ASSERT d_eq = '0' and d_neq = '1' 
REPORT "Problem with equality at LSB"
SEVERITY error ; 


d_in1 <= "11111111" ; 
d_in2 <= "11111111" ;
WAIT FOR 15 ns ;  
ASSERT d_eq = '1' and d_neq = '0' 
REPORT "Problem with equality ar one"
SEVERITY error; 


d_in1 <= "10101010" ; 
d_in2 <= "10101010" ; 
WAIT FOR 15 ns ;
ASSERT d_eq = '1' and d_neq = '0' 
REPORT "Problem with Equality Flipped bits"
SEVERITY error; 
 

d_in1 <= "10101010" ; 
d_in2 <= "01010101" ; 
WAIT FOR 15 ns ;
ASSERT d_eq = '0' and d_neq = '1' 
REPORT "Problem with inequality Flipped bits"
SEVERITY error; 

WAIT;


END PROCESS P1 ; 




END ARCHITECTURE behav;