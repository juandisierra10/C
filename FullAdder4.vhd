LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------
ENTITY FullAdder4 IS
    PORT (      A       : IN    STD_LOGIC;
                B       : IN    STD_LOGIC;
                Cin     : IN    STD_LOGIC;
                S       : OUT   STD_LOGIC;
                Cout   : OUT STD_LOGIC);
END ENTITY FullAdder4;
-------------------------------------------
ARCHITECTURE functional OF FullAdder4 IS
    SIGNAL p0:  STD_LOGIC;
    SIGNAL p1:  STD_LOGIC;
    SIGNAL p2:  STD_LOGIC;
BEGIN
    S <= p0 XOR Cin;
   Cout <= p1 OR p2;
-------------------------------------
    p0 <= A XOR B;
    p1 <= A AND B;
    p2 <= p0 AND Cin;

END functional;