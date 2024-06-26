----------------------------------------------------------------
-- An FSM using VHDL and Johnson state encoding for states
----------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.const_johnson_encoding.ALL;

ENTITY angle IS
  PORT( cw, ccw, reset, clk: IN std_logic;
        angle : OUT std_logic_vector (2 DOWNTO 0));
END ENTITY angle;

ARCHITECTURE angle OF angle IS
  SIGNAL current_state, next_state: unsigned (3 DOWNTO 0);
  -- states have same number of bits as Johnson encoding
  -- style of  ang_0, ang_1, cdots , ang_7
BEGIN
  CS: PROCESS IS
  BEGIN
    WAIT UNTIL rising_edge(clk); 
    IF reset = '1' THEN -- synchronous reset
      current_state <= ang_0;
    ELSE 
      current_state <= next_state;
    END IF;
  END PROCESS CS;

  NS: PROCESS (current_state, cw, ccw) IS BEGIN
    CASE current_state IS
      WHEN ang_0 => 
        IF cw = '1' AND ccw = '0' THEN
          next_state <= ang_1;
        ELSIF cw = '0' AND ccw = '1' THEN
           next_state <= ang_7;
        ELSE next_state <= ang_0;
        END IF;
      WHEN ang_1 => 
        IF cw = '1' AND ccw = '0' THEN 
          next_state <= ang_2;
        ELSIF cw = '0' AND ccw = '1' THEN
           next_state <= ang_0;
        ELSE next_state <= ang_1;
        END IF;
      WHEN ang_2 => 
        IF cw = '1' AND ccw = '0' THEN 
          next_state <= ang_3;
        ELSIF cw = '0' AND ccw = '1' THEN
           next_state <= ang_1;
        ELSE next_state <= ang_2;
        END IF;
      WHEN ang_3 => 
        IF cw = '1' AND ccw = '0' THEN 
          next_state <= ang_4;
        ELSIF cw = '0' AND ccw = '1' THEN
           next_state <= ang_2;
        ELSE next_state <= ang_3;
        END IF;
      WHEN ang_4 => 
        IF cw = '1' AND ccw = '0' THEN 
          next_state <= ang_5;
        ELSIF cw = '0' AND ccw = '1' THEN
           next_state <= ang_3;
        ELSE next_state <= ang_4;
        END IF;
      WHEN ang_5 => 
        IF cw = '1' AND ccw = '0' THEN 
          next_state <= ang_6;
        ELSIF cw = '0' AND ccw = '1' THEN
           next_state <= ang_4;
        ELSE next_state <= ang_5;
        END IF;
      WHEN ang_6 => 
        IF cw = '1' AND ccw = '0' THEN
          next_state <= ang_7;
        ELSIF cw = '0' AND ccw = '1' THEN 
         next_state <= ang_5;
        ELSE next_state <= ang_6;
        END IF;
      WHEN ang_7 => 
        IF cw = '1' AND ccw = '0' THEN
          next_state <= ang_0;
        ELSIF cw = '0' AND ccw = '1' THEN 
         next_state <= ang_6;
        ELSE next_state <= ang_7;
        END IF;
      WHEN OTHERS =>
        next_state <= ang_0;
    END CASE;
  END PROCESS NS;

  OP: PROCESS (current_state) IS
  BEGIN
    CASE current_state IS
      WHEN ang_0 => angle <= o"0";
      WHEN ang_1 => angle <= o"1";
      WHEN ang_2 => angle <= o"2";
      WHEN ang_3 => angle <= o"3";
      WHEN ang_4 => angle <= o"4";
      WHEN ang_5 => angle <= o"5";
      WHEN ang_6 => angle <= o"6";
      WHEN ang_7 => angle <= o"7";
      WHEN OTHERS => NULL;
    END CASE;
  END PROCESS OP;
END ARCHITECTURE angle;