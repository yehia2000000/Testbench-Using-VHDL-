----------------------------------------------------------------
-- VHDL code for an FSM using a two-process architecture. 
-- The FSM has Moore and Mealy outputs. States are represented 
-- using integers.
----------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY source IS
  PORT( u, d, reset: IN bit;
        clk: IN std_logic;
        inc, dec, c: OUT bit);   
END ENTITY source;

ARCHITECTURE fsm OF source IS 
  SIGNAL current_state, next_state: integer RANGE 0 TO 1; 
BEGIN
  CS: PROCESS (clk, reset) IS BEGIN
    IF reset = '1' THEN -- Asynchronous reset
      current_state <= 0;
    ELSIF rising_edge(clk)  THEN
      current_state <= next_state;
    END IF;
  END PROCESS CS;

  NS: PROCESS (current_state, u, d) IS 
  BEGIN
    CASE current_state IS
      WHEN 0 =>  
	c <= '0'; -- Moore output
        IF u = '1' THEN 
          inc <= '1'; 
          dec <= '0'; 
          next_state <= 1;
        ELSE 
          inc <= '0'; 
          dec <= '0'; 
          next_state <= 0;
        END IF;
      WHEN 1 => 
	c <= '1';
        IF d = '1' THEN 
          inc <= '0'; 
          dec <= '1'; 
          next_state <= 0;
        ELSE 
          inc <= '0'; 
          dec <= '0'; 
Ø          next_state <= 1;
        END IF;
    END CASE;
  END PROCESS NS;
END ARCHITECTURE fsm;