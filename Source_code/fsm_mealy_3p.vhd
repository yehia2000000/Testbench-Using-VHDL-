----------------------------------------------------------------
-- An odd parity checker as an FSM using VHDL.
-- Coding style: Three processes Mealy.
----------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fsm IS
  PORT( clk, reset: IN std_logic;
        x: IN std_logic;
        y: OUT std_logic);
END ENTITY fsm;

ARCHITECTURE mealy_3p OF fsm IS
  TYPE state_type IS (even, odd);
  SIGNAL current_state: state_type;
  SIGNAL next_state: state_type;
BEGIN
  cs: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      current_state <= even;
    ELSIF rising_edge (clk) THEN
      current_state <= next_state;
    END IF;
  END PROCESS cs;

  ns: PROCESS (current_state, x)
  BEGIN
    CASE current_state IS
      WHEN even =>
        IF x = '1' THEN
          next_state <= odd;
        ELSE
          next_state <= even;
        END IF;
      WHEN odd =>
        IF x = '1' THEN
          next_state <= even;
        ELSE
          next_state <= odd;
        END IF;
    END CASE;
  END PROCESS ns;

  op: PROCESS (current_state, x)
  BEGIN
    CASE current_state IS
      WHEN even =>
        IF x = '1' THEN
          y <= '1';
        ELSE
          y <= '0';
        END IF;
      WHEN odd =>
        IF x = '1' THEN
          y <= '0';
        ELSE
          y <= '1';
        END IF;
    END CASE;
  END PROCESS OP;
END ARCHITECTURE mealy_3p;