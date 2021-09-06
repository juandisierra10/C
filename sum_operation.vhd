---------Function of add----- 
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------
ENTITY sum_operation IS
	PORT ( 		A:	IN		STD_LOGIC_VECTOR (3 DOWNTO 0); ---- Number A
			      B:   IN    STD_LOGIC_VECTOR(3 DOWNTO 0); ---Number B
					S       : OUT   STD_LOGIC_VECTOR (4 DOWNTO 0)); ---Result
END ENTITY sum_operation;
------------------------------------------
ARCHITECTURE operation OF sum_operation IS
        SIGNAL p0:  STD_LOGIC;
        SIGNAL p1:  STD_LOGIC;
        SIGNAL p2:  STD_LOGIC;
BEGIN
 
-----Operation Full Adder of 4 bits----- 
fullAdder_1: ENTITY work.FullAdder4
    PORT MAP (      A => A(0),
                    B => B(0),
                    Cin => '0',
                    S => S(0),
                    Cout => p0);
    fullAdder_2: ENTITY work.FullAdder4
     PORT MAP (     A => A(1),
                    B => B(1),
                    Cin => p0 ,
                    S => S(1),
                    Cout => p1);
     fullAdder_3: ENTITY work.FullAdder4
     PORT MAP (     A => A(2),
						 B => B(2),
                   Cin => p1 ,
                   S => S(2),
                    Cout => p2);
      fullAdder_4: ENTITY work.FullAdder4
      PORT MAP (    A => A(3),
                    B => B(3),
                   Cin => p2 ,
                   S => S(3),
                   Cout => S(4));
END ARCHITECTURE operation;