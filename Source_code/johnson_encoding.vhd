----------------------------------------------------------------
-- Definition of 8 states in a package using a constant for 
-- each state, using Johnson state encoding for states.
----------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE const_johnson_encoding IS
   CONSTANT ang_0: unsigned(3 DOWNTO 0) := "0000";
   CONSTANT ang_1: unsigned(3 DOWNTO 0) := "0001";
   CONSTANT ang_2: unsigned(3 DOWNTO 0) := "0011";
   CONSTANT ang_3: unsigned(3 DOWNTO 0) := "0111";
   CONSTANT ang_4: unsigned(3 DOWNTO 0) := "1111";
   CONSTANT ang_5: unsigned(3 DOWNTO 0) := "1110";
   CONSTANT ang_6: unsigned(3 DOWNTO 0) := "1100";
   CONSTANT ang_7: unsigned(3 DOWNTO 0) := "1000";
END PACKAGE const_johnson_encoding;