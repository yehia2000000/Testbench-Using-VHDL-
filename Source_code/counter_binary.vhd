----------------------------------------------------------------
-- An n-bit binary up/down counter with synchronous 
-- preset and clear.
----------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY bin_counter IS
  GENERIC( n: positive := 4);
  PORT( clk, clear, up_down: IN std_logic;
        preset: IN std_logic;
        d_in: IN unsigned (n-1 DOWNTO 0);
        d_out: OUT unsigned (n-1 DOWNTO 0));
END ENTITY bin_counter;

ARCHITECTURE behav OF bin_counter IS
  SIGNAL counter: unsigned (n-1 DOWNTO 0);
BEGIN
  ct: PROCESS (clk) IS
  BEGIN
    IF rising_edge (clk) THEN
      IF clear = '1' THEN
        counter <= (OTHERS => '0');
      ELSIF preset = '1' THEN
        counter <= d_in;
      ELSIF up_down = '1' THEN
        counter <= counter + 1;
      ELSE
        counter <= counter - 1;
      END IF; 
    END IF; 
  END PROCESS ct;
  d_out <= counter;
END ARCHITECTURE behav;