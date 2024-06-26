
LIBRARY IEEE ; 
USE IEEE.STD_LOGIC_1164.ALL ; 
USE IEEE.numeric_STD.ALL;

PACKAGE Tb_pk IS
COMPONENT Tb_com IS 
  GENERIC( n : integer := 3;
           m : integer := 6);
  PORT(	enable: IN std_logic;
		address: IN unsigned (n-1 DOWNTO 0);
		data: OUT unsigned (m-1 DOWNTO 0));
END COMPONENT Tb_com ; 
END PACKAGE Tb_pk ; 

LIBRARY IEEE ; 
USE IEEE.STD_LOGIC_1164.ALL ; 
USE IEEE.numeric_STD.ALL;
USE WORK.Tb_pk.ALL;

ENTITY Tb_rom IS 
END ENTITY Tb_rom ; 

ARCHITECTURE behav OF Tb_rom IS 
CONSTANT n : INTEGER := 3 ;
CONSTANT m :INTEGER := 6 ;  
SIGNAL addr: unsigned (n-1 DOWNTO 0);
SIGNAL data: unsigned (m-1 DOWNTO 0);
SIGNAL en : STD_LOGIC ; 
SIGNAL dt : STD_LOGIC_VECTOR (m-1 DOWNTO 0) ; 

FOR DUT  : Tb_com USE ENTITY WORK.rom (flag_arch) ;
BEGIN 
DUT : Tb_com GENERIC MAP ( n => 3 , m =>6) PORT MAP (en , addr , data);
test : PROCESS IS 
BEGIN 

WAIT FOR 2 ns ; 
en <= '0' ; 
dt <= STD_LOGIC_VECTOR (data);
WAIT FOR 4 ns ; 
ASSERT dt = "ZZZZZZ";
REPORT "problem in output when ROM is disabled"
SEVERITY warning ; 

WAIT FOR 4 ns ; 
en <= '1' ;
addr <= "000" ; 
WAIT FOR 2 ns ; 
ASSERT data = "000000" 
REPORT "problem in address : 000 "
SEVERITY warning ; 

WAIT FOR 2 ns ; 
en <= '1' ;
addr <= "101" ; 
WAIT FOR 2 ns ; 
ASSERT data = "011001" 
REPORT "problem in address : 101 "
SEVERITY warning ; 


WAIT FOR 2 ns ; 
en <= '1' ;
addr <= "001" ;
WAIT FOR 2 ns ; 
ASSERT data = "000001" 
REPORT "problem in address : 001 "
SEVERITY warning ; 

WAIT FOR 2 ns ; 
en <= '1' ;
addr <= "010" ;
WAIT FOR 2 ns ; 
ASSERT data = "000100" 
REPORT "problem in address : 010 "
SEVERITY warning ; 

WAIT FOR 2 ns ; 
en <= '1' ;
addr <= "100";
WAIT FOR 2 ns ; 
ASSERT data = "010000" 
REPORT "problem in address : 100 "
SEVERITY warning ; 

WAIT FOR 2 ns ; 
en <= '1' ;
addr <= "111" ;
WAIT FOR 2 ns ; 
ASSERT data = "110001" 
REPORT "problem in address : 111 "
SEVERITY warning ; 

WAIT ; 
END PROCESS test ; 



END ARCHITECTURE behav ; 