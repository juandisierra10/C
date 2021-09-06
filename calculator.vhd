LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------------------------------------------------
ENTITY calculator IS
	PORT(	a_bin:	IN		STD_LOGIC_VECTOR (3 DOWNTO 0); ----Selection of Num A-----
			b_bin:   IN    STD_LOGIC_VECTOR(3 DOWNTO 0);------Selection of Num B----
			sum_res: IN    STD_LOGIC;						  ------Switch for sum or substraction-----
			mult :   IN    STD_LOGIC;						  -------Switch for multiplication-------
			sseg_a:  OUT   STD_LOGIC_VECTOR(6 DOWNTO 0);-------7 segments that displays number A------
			sseg_b:  OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);-------7 segments that displays number B------
			sseg_c:  OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);-------7 segments that displays tens or negative sign------
			sseg_d:  OUT   STD_LOGIC_VECTOR(6 DOWNTO 0));------7 segments that displays units--------
END ENTITY calculator;
-----------------------------------------------------------------------------------------------------------------
ARCHITECTURE functional OF calculator IS
--------------------------------------------------------------------------------------------------------- 
  SIGNAL  switch_enable: STD_LOGIC_VECTOR(1 DOWNTO 0); ------Compares which result will be displayed------
  SIGNAL  Result_1:    STD_LOGIC_VECTOR(4 DOWNTO 0);  -------------------Result of add--------------
  SIGNAL		sseg_c_add:  	STD_LOGIC_VECTOR(6 DOWNTO 0);-------7 segments that displays tens of add------
  SIGNAL		sseg_d_add:     STD_LOGIC_VECTOR(6 DOWNTO 0);------7 segments that displays units of add--------
  SIGNAL		sseg_c_sub:  	STD_LOGIC_VECTOR(6 DOWNTO 0);-------7 segments that displays negative sign------
  SIGNAL		sseg_d_sub:     STD_LOGIC_VECTOR(6 DOWNTO 0);------7 segments that displays units of substraction--------
  SIGNAL		sseg_c_mult:  	STD_LOGIC_VECTOR(6 DOWNTO 0);-------7 segments that displays tens of multiplication------
  SIGNAL		sseg_d_mult:     STD_LOGIC_VECTOR(6 DOWNTO 0);------7 segments that displays units of multiplication--------
 -------------------------------------------------------------------------------------------------------------------- 
	
BEGIN 
      switch_enable <= sum_res & mult;
		------SElECTION OF RESULTS TO DISPLAY (ADD, SUBSTRACTION OR MULTIPLICATION)--------
      selection: PROCESS (switch_enable,sseg_c_add,sseg_d_add,sseg_c_sub,sseg_d_sub,sseg_c_mult,sseg_d_mult)
		BEGIN
		IF (switch_enable="11") THEN   ------------Displays add-----------------
			sseg_c <= sseg_c_add;
			sseg_d <= sseg_d_add;
		ELSIF (switch_enable="01") THEN ----------Displays substraction---------
			sseg_c <= sseg_c_sub;
			sseg_d <= sseg_d_sub;
		ELSE                           ---------Displays multiplication---------
		   sseg_c <= sseg_c_mult;
			sseg_d <= sseg_d_mult;
		END IF;
		END PROCESS;
		
	   --------SELECTION OF NUMBER A--------
		selection_a: ENTITY work.bin_to_sseg
		PORT MAP   (bin	=> a_bin,
					   sseg => sseg_a);
						
		--------SELECTION OF NUMBER B--------
		selection_b: ENTITY work.bin_to_sseg
		PORT MAP   (bin	=> b_bin,
					   sseg => sseg_b);
						
		---------Function of add---------
		sum_total: ENTITY work.sum_operation
      PORT MAP (    A => a_bin,
                    B => b_bin,
                    S => Result_1);
						  
		---------Function of substraction and also print its result----- 
		substraction_total: ENTITY work.substraction_operation
      PORT MAP (    A => a_bin,
                    B => b_bin,
						  sseg_c=>sseg_c_sub,
                    sseg_d=> sseg_d_sub);
						  
		--------Function to print result of add-----
		print_sum: ENTITY work.comparator
	   PORT MAP ( result => Result_1,
					  a_bin => a_bin,
					  b_bin => b_bin,
    			     sseg_c=> sseg_c_add,
					  sseg_d=> sseg_d_add);
		
		--------Function of multiplication------
		multiplication_total: ENTITY work.multiplication_operation
      PORT MAP (    A => a_bin,
                    B => b_bin,
						  sseg_c=> sseg_c_mult,
						   sseg_d=> sseg_d_mult);
END ARCHITECTURE functional;
		