--------Function of multiplication------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------------------------------------------------
ENTITY multiplication_operation IS
	PORT(	A:	IN		STD_LOGIC_VECTOR (3 DOWNTO 0); ----Selection of Num A-----
			B:   IN    STD_LOGIC_VECTOR(3 DOWNTO 0);------Selection of Num B----
			sseg_c:  OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);-------7 segments that displays tens------
			sseg_d:  OUT   STD_LOGIC_VECTOR(6 DOWNTO 0));------7 segments that displays units--------

END ENTITY multiplication_operation;
------------------------------------------------------------------------------------------------------------
ARCHITECTURE operational OF multiplication_operation IS
		SIGNAL enable,p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17:  STD_LOGIC; -------Signals for carrys in the partial adds and an enable-----
		SIGNAL  aux : STD_LOGIC_VECTOR(3 DOWNTO 0);    ------Aux to print units
		SIGNAL  Result_1 : STD_LOGIC_VECTOR(3 DOWNTO 0); -----Result of first multiplication-----
		SIGNAL  Result_2 : STD_LOGIC_VECTOR(3 DOWNTO 0); -----Result of second multiplication-----
	   SIGNAL  Result_3 : STD_LOGIC_VECTOR(3 DOWNTO 0); -----Result of third multiplication-----
	   SIGNAL  Result_4 : STD_LOGIC_VECTOR(3 DOWNTO 0); -----Result of fourth multiplication-----
	   SIGNAL S    :      STD_LOGIC_VECTOR (7 DOWNTO 0); ------Total result after applying full adders----
BEGIN
       ------------Confirm if both numbers in range-----
      enable <= '1' WHEN (A<"1010" AND B<"1010") ELSE 
				    '0';
     Result_1 <= (A(3) AND  B(0))&(A(2) AND  B(0))&(A(1) AND  B(0))&(A(0) AND B(0));
	  Result_2 <= (A(3) AND  B(1))&(A(2) AND  B(1))&(A(1) AND  B(1))&(A(0) AND B(1));
	  Result_3 <= (A(3) AND  B(2))&(A(2) AND  B(2))&(A(1) AND  B(2))&(A(0) AND B(2));
	  Result_4 <= (A(3) AND  B(3))&(A(2) AND  B(3))&(A(1) AND  B(3))&(A(0) AND B(3));
	  S(0)<=Result_1(0);
	  
    ---------Result of S(1)--------------
	 fullAdder_1: ENTITY work.FullAdder4
    PORT MAP (      A => Result_1(1),  
                    B => Result_2(0),
                    Cin => '0',
                    S => S(1),
                    Cout => p0);
		--------Result of S(2)--------------
	 fullAdder_2: ENTITY work.FullAdder4
    PORT MAP (      A => Result_1(2),
                    B => Result_2(1),
                    Cin => p0,
                    S => p1,
                    Cout => p2);
	 fullAdder_3: ENTITY work.FullAdder4
    PORT MAP (      A => Result_3(0),
                    B => p1,
                    Cin => '0',
                    S => S(2),
                    Cout => p3);
		--------Result of S(3)--------------
	 fullAdder_4: ENTITY work.FullAdder4
    PORT MAP (      A => Result_1(3),
                    B => Result_2(2),
                    Cin => p2,
                    S => p4,
                    Cout => p5);
	 fullAdder_5: ENTITY work.FullAdder4
    PORT MAP (      A => Result_3(1),
                    B => p4,
                    Cin => p3,
                    S => p6,
                    Cout => p7);
	 fullAdder_6: ENTITY work.FullAdder4
    PORT MAP (      A => Result_4(0),
                    B => p6,
                    Cin => '0',
                    S => S(3),
                    Cout => p8);
		--------Result of S(4)--------------
	 fullAdder_7: ENTITY work.FullAdder4
    PORT MAP (      A => Result_2(3),
                    B => '0',
                    Cin => p5,
                    S => p9,
                    Cout => p10);
	 fullAdder_8: ENTITY work.FullAdder4
    PORT MAP (      A => p9,
                    B => Result_3(2),
                    Cin => p7,
                    S => p11,
                    Cout => p12);
	 fullAdder_9: ENTITY work.FullAdder4
    PORT MAP (      A => p11,
                    B => Result_4(1),
                    Cin => p8,
                    S => S(4),
                    Cout => p13);
				--------Result of S(5)--------------
	 fullAdder_10: ENTITY work.FullAdder4
    PORT MAP (      A => p10,
                    B => Result_3(3),
                    Cin => p12,
                    S => p14,
                    Cout => p15);
	 fullAdder_11: ENTITY work.FullAdder4
    PORT MAP (      A => p14,
                    B => Result_4(2),
                    Cin => p13,
                    S => S(5),
                    Cout => p16);
					--------Result of S(6)--------------
	 fullAdder_12: ENTITY work.FullAdder4
    PORT MAP (      A => p15,
                    B => Result_4(3),
                    Cin => p16,
                    S => S(6),
                    Cout => S(7));
		-------------Process to print tens----------------
		print_tens: PROCESS (S,enable)		
		BEGIN
		-----------0 tens-----------
		IF ((S<"00001010")AND (enable='1')) THEN         
			sseg_c <= "1111111";
			
		--------1 ten-----------
	   ELSIF ((("00001001"<S) AND (S<"00010100"))AND(enable='1')) THEN 
		   sseg_c <= "1111001";
			
		----------2 tens---------
		ELSIF ((("00010011"<S)AND(S<"00011110"))AND(enable='1')) THEN 
			sseg_c<="0100100";
			
		----------3 tens-----------
		ELSIF((("00011101"<S)AND(S<"00101000"))AND(enable='1')) THEN 
			sseg_c<="0110000";
			
		--------4 tens------------
		ELSIF ((("00100111"<S)AND(S<"00110010"))AND(enable='1')) THEN 
		   sseg_c<="0011001";
			
		 -------5 tens-----------
		ELSIF ((("00110001"<S)AND(S<"00111100"))AND(enable='1')) THEN
			sseg_c<="0010010";
			
		---------6 tens------------
		ELSIF((("00111011"<S)AND(S<"01000110"))AND(enable='1')) THEN 
		   sseg_c<="0000010";
		
		--------7 tens------------
		ELSIF((("01000101"<S)AND(S<"01010000"))AND(enable='1')) THEN 
		   sseg_c<="1111000";
		
		-------8 tens (80,81)------
		ELSIF((("01001111"<S)AND(S<"01010010"))AND(enable='1')) THEN 
		   sseg_c<="0000000";
			
		-------Error------------
		ELSE
		   sseg_c<= "0000110"; 
		END IF;
		END PROCESS;
		
		--------------Process to print units-------------
		print_units: PROCESS (aux,S)  
		BEGIN
		--If 0,10,20,30,40,50,60,70,80
		IF (((S="00000000") OR (S="00001010")OR(S="00010100")OR(S="00011110")OR(S="00101000")OR(S="00110010")OR(S="00111100")OR(S="1000110")OR (S="01010000"))AND(enable='1')) THEN 
			aux<="0000";
		
		--If 1,11,21,31,41,51,61,71,81
		ELSIF(((S="00000001") OR (S="00001011")OR(S="00010101")OR(S="00011111")OR(S="00101001")OR(S="00110011")OR(S="00111101")OR(S="1000111")OR (S="01010001"))AND(enable='1')) THEN 
			aux<="0001";
			
		--If 2,12,22,32,42,52,62,72	
		ELSIF(((S="00000010") OR (S="00001100")OR(S="00010110")OR(S="00100000")OR(S="00101010")OR(S="00110100")OR(S="00111110")OR(S="01001000"))AND(enable='1')) THEN 
			aux<="0010";
			
		--If 3,13,23,33,43,53,63,73
		ELSIF (((S="00000011") OR (S="00001101")OR(S="00010111")OR(S="00100001")OR(S="00101011")OR(S="00110101")OR(S="00111111")OR(S="01001001"))AND(enable='1')) THEN 
			aux<="0011";
		
		--If 4,14,24,34,44,54,64,74
		ELSIF (((S="00000100") OR (S="00001110")OR(S="00011000")OR(S="00100010")OR(S="00101100")OR(S="00110110")OR(S="01000000")OR(S="01001010"))AND(enable='1')) THEN 
		   aux<="0100";
		
		--If 5,15,25,35,45,55,65,75
		ELSIF (((S="00000101") OR (S="00001111")OR(S="00011001")OR(S="00100011")OR(S="00101101")OR(S="00110111")OR(S="01000001")OR(S="01001011"))AND(enable='1')) THEN 
		   aux<="0101";
			
		--If 6,16,26,36,46,56,66,76
		ELSIF (((S="00000110") OR (S="00010000")OR(S="00011010")OR(S="00100100")OR(S="00101110")OR(S="00111000")OR(S="01000010")OR(S="01001100"))AND(enable='1')) THEN 
			aux<="0110";
		
		--If 7,17,27,37,47,57,67,77
		ELSIF (((S="00000111") OR (S="00010001")OR(S="00011011")OR(S="00100101")OR(S="00101111")OR(S="00111001")OR(S="01000011")OR(S="01001101"))AND(enable='1')) THEN 
		   aux<="0111";
		
		--If 8,18,28,38,48,58,68,78
		ELSIF (((S="00001000") OR (S="00010010")OR(S="00011100")OR(S="00100110")OR(S="00110000")OR(S="00111010")OR(S="01000100")OR(S="01001110"))AND(enable='1')) THEN 
		  aux<="1000";
		 
		--If 9,19,29,39,49,59,69,79
		ELSIF (((S="00001001") OR (S="00010011")OR(S="00011101")OR(S="00100111")OR(S="00110001")OR(S="00111011")OR(S="01000101")OR(S="01001111"))AND(enable='1')) THEN 
		  aux<="1001";
		 
		ELSE
		  aux<="1111";
		END IF;
		END PROCESS;
		-------Function to print units-------
      result2: ENTITY work.bin_to_sseg
  	  PORT MAP     (bin  => aux,
     				   sseg => sseg_d);
END ARCHITECTURE operational;
    