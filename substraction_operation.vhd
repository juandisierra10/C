---------Function of substraction and also print result----- 
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------------------------------------------------
ENTITY substraction_operation IS
	PORT ( 	A:	IN		STD_LOGIC_VECTOR (3 DOWNTO 0); ----Number A.-----
          	B:   IN    STD_LOGIC_VECTOR(3 DOWNTO 0); ----Number B---
				sseg_c:  OUT   STD_LOGIC_VECTOR(6 DOWNTO 0); --- 7 Segments to display or not negative sign-----
 				sseg_d:  OUT   STD_LOGIC_VECTOR(6 DOWNTO 0)); ---7 Segments to display result---
END ENTITY;
------------------------------------------------------------------------------------------------------------
ARCHITECTURE operation OF substraction_operation IS

		SIGNAL  B_c2 : STD_LOGIC_VECTOR (3 DOWNTO 0); -------Signal of the number that has to be in two complement---
		SIGNAL enable: STD_LOGIC; ----------------Enable to confirm if A and B are in range--------------------
		SIGNAL enable_1: STD_LOGIC;--------------Enable to confirm which number is greater--------------
		SIGNAL enable_2: STD_LOGIC_VECTOR(1 DOWNTO 0); ----------Enable to concatenate the 2 previous enables-----
		SIGNAL A_new:		STD_LOGIC_VECTOR (3 DOWNTO 0); ------Number A that enters to the operation of full adder-----
		SIGNAL B_new:		STD_LOGIC_VECTOR (3 DOWNTO 0); ------Number B that enters to the operation of full adder-----
		SIGNAL  Result_1 : STD_LOGIC_VECTOR(4 DOWNTO 0); ------Result of the general full adder----------------------
		SIGNAL   S:   STD_LOGIC_VECTOR (4 DOWNTO 0); ----------Result of the number in two complement--------
BEGIN
 ---------------------------------------------------- 
  ------------Confirm if both numbers in range-----
  enable <= '1' WHEN (A<"1010" AND B<"1010") ELSE 
				 '0';
	-----------Confirm which number is greater
  enable_1 <= '1' WHEN (A < B) ELSE
				  '0' ;
				  
  enable_2 <= enable & enable_1;	
  
  --------------Display sign (positive nothing, negative or error)---------
  sseg_c <= "1111111" WHEN enable_2="10" ELSE
				"0111111" WHEN enable_2="11" ELSE
				"0000110";
	
	---------Process to determine which number has to have the two complement---
  comparator: PROCESS (enable_2,A,B)
  BEGIN
  
  ------If A is greater than B, the complement applies to B------
  IF (enable_2="10") THEN
     A_new <= A;
	  B_c2 <= (NOT B);
	  B_new <= S (3 DOWNTO 0);
	  
	------If B is greater than A, the complement applies to A------
	ELSIF (enable_2="11") THEN
	  A_new <= B;
	  B_c2 <= (NOT A);
	  B_new <= S (3 DOWNTO 0);
	 ELSE
	 
	 --------If none, send numbers to display error----------
		  A_new <= "1111"; 
	     B_c2 <= "1101";
		  B_new <= S (3 DOWNTO 0);
	  END IF;
	 END PROCESS;
	
	----------Function of two complement-------
  two_complement: ENTITY work.sum_operation
  PORT MAP (        A => B_c2,
                    B => "0001",      
                    S => S);
	
	----------Function of full adder------------
  Full_Adder_substraction: ENTITY work.sum_operation
  PORT MAP (        A => A_new,
                    B => B_new,      
                    S => Result_1);
						  
	----------Function to print result----------					  
	result_2: ENTITY work.bin_to_sseg
  	PORT MAP      (bin  => Result_1(3 DOWNTO 0),
     				   sseg => sseg_d);
END ARCHITECTURE; 
	