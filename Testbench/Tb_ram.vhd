
LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL ; 
USE IEEE.NUMERIC_STD.ALL; 

PACKAGE Tb_pk IS 
COMPONENT Tb_com IS 
	GENERIC(	n: positive := 4;
				m: positive := 4);
	PORT(	r, w: IN std_logic;
			address_in: IN unsigned (n-1 DOWNTO 0);
			address_out: IN unsigned (n-1 DOWNTO 0);
			data_in: IN std_logic_vector (m-1 DOWNTO 0);
			data_out: OUT std_logic_vector (m-1 DOWNTO 0));

END COMPONENT Tb_com ; 
END PACKAGE Tb_pk ; 

LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL ; 
USE IEEE.NUMERIC_STD.ALL; 
USE WORK.Tb_pk.ALL ; 

ENTITY Tb_ram IS 
END ENTITY Tb_ram ; 

ARCHITECTURE Tb_behav OF Tb_ram IS
CONSTANT n : positive  := 4 ; 
CONSTANT m : positive := 4 ;
FOR DUT : Tb_com USE ENTITY WORK.dual_port_ram (behav);
SIGNAL r, w:std_logic;
SIGNAL addr_in , addr_out:unsigned (n-1 DOWNTO 0);
SIGNAL da_in , da_out : std_logic_vector (m-1 DOWNTO 0);
BEGIN 

DUT : Tb_com GENERIC MAP (n =>4 , m=>4) PORT MAP (r,w,addr_in , addr_out , da_in , da_out) ; 
test : PROCESS IS 
BEGIN 
----------------------------------write case---------------------------------------------
WAIT FOR 2 ns ; 
w <= '1' ; 
r <= '0' ; 
addr_in <= "0000" ; 
da_in <= "1010" ; 
WAIT FOR 2 ns ; 
----------------------------------write case ---------------------------------------------
WAIT FOR 2 ns ; 
w <= '1' ; 
r <= '0' ; 
addr_in <= "1111" ; 
da_in <= "0011" ; 
WAIT FOR 2 ns ; 
----------------------------------read case ---------------------------------------------
WAIT FOR 2 ns ; 
w <= '0' ; 
r <= '1' ; 
addr_out <= "0000" ; 
WAIT FOR 2 ns ; 
ASSERT da_out = "1010" 
REPORT "problem in writing or read the data in address : 0000"
SEVERITY warning ;

----------------------------------read case ---------------------------------------------
WAIT FOR 2 ns ; 
w <= '0' ; 
r <= '1' ; 
addr_out <= "1111" ; 
WAIT FOR 2 ns ; 
ASSERT da_out = "0011" 
REPORT "problem in writing or read the data in address : 1111"
SEVERITY warning ;

----------------------------------write and read case s ---------------------------------------------
WAIT FOR 2 ns ; 
w <= '1' ; 
r <= '1' ; 
addr_in <= "0011" ; 
addr_out <= "0000" ; 
da_in <= "1100" ; 
WAIT FOR 2 ns ; 
ASSERT da_out = "1010" 
REPORT "problem in  writing or reading  the data in address 0000"
SEVERITY warning ;

----------------------------------read case  ---------------------------------------------
WAIT FOR 2 ns ; 
w <= '0' ; 
r <= '1' ; 
addr_out <= "0011" ; 
WAIT FOR 2 ns ;  
ASSERT da_out = "1100" 
REPORT "problem in writing or read the data in address : 0011"
SEVERITY warning ;


WAIT ; 
END PROCESS test ; 


END ARCHITECTURE Tb_behav ; 