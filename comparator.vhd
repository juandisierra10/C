---------Function that separates decens and units of the add--------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------------
ENTITY comparator IS
		PORT (result : IN STD_LOGIC_VECTOR (4 DOWNTO 0); ----------- Result of add--------
				a_bin:	IN		STD_LOGIC_VECTOR (3 DOWNTO 0); -------Number A--------
			   b_bin:   IN    STD_LOGIC_VECTOR(3 DOWNTO 0); -------Number B-----------
		      sseg_c:  OUT   STD_LOGIC_VECTOR(6 DOWNTO 0); -------7 segments that displays tens------
				sseg_d:  OUT   STD_LOGIC_VECTOR(6 DOWNTO 0)); ------7 segments that displays units--------
END ENTITY; 
------------------------------------------------------------------------------------------------
ARCHITECTURE gateLevel OF comparator IS
------------------------------------------------------------------------------------------------
	SIGNAL   aux  : STD_LOGIC_VECTOR (3 DOWNTO 0); -----Aux to send units to 7 segments----------
	SIGNAL   enable: STD_LOGIC; --------Enable that determines if A or B are less or more than 10-----
	SIGNAL   result_1:   STD_LOGIC_VECTOR (5 DOWNTO 0); -----Vector to concatenate the enable and the actual result----
----------------------------------------------------------------------------------------------------
BEGIN
       result_1 <= enable & result;
		 ----Function to print units------
       sum_result_less_than_9: ENTITY work.bin_to_sseg
       PORT MAP   (bin	=> aux,
					   sseg => sseg_d);
		-----------------------------------------------------
	   enable <= '1' WHEN (a_bin<"1010" AND b_bin<"1010") ELSE ------Enable if both A and B are less than 10
					 '0';
		------------------------------------------------------
		print_sum: PROCESS (result_1,aux)
		BEGIN
				IF(result<"01010") THEN	
					sseg_c <= "1111111"; ------Display C does not display anything
				   aux <= result(3) & result(2) & result(1) & result (0); --Confims that is less than 10
					
				---The rest of if sseg_c has the value of 1 only--------------
				ELSIF (result_1="101010") THEN --When result is 10
					sseg_c <= "1111001";
					aux <= "0000";
				ELSIF(result_1="101011") THEN -- When result is 11
					sseg_c <= "1111001";
					aux <= "0001";
				ELSIF(result_1="101100") THEN --When result is 12
					sseg_c <= "1111001";
					aux <= "0010";
				ELSIF(result_1="101101") THEN --When result is 13
					sseg_c <= "1111001";
					aux <= "0011";
				ELSIF(result_1="101110") THEN --When result is 14
					sseg_c <= "1111001";
					aux <= "0100";
				ELSIF(result_1="101111") THEN --When result is 15
					sseg_c <= "1111001";
					aux <= "0101";
				ELSIF(result_1="110000") THEN --When result is 16
					sseg_c <= "1111001";
					aux <= "0110";
				ELSIF(result_1="110001") THEN --When result is 17
					sseg_c <= "1111001";
					aux <= "0111";
				ELSIF(result_1="110010") THEN --When result is 18
					sseg_c <= "1111001";
					aux <= "1000";
				ELSE
					sseg_c <= "0000110"; --When A or B are not in the range
					aux <= "1111";
				END IF;
			END PROCESS print_sum;
			         
END ARCHITECTURE gatelevel;

	