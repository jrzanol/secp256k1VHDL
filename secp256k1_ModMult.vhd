LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

LIBRARY work;
USE work.MYWORK.all;

ENTITY secp256k1_ModMult IS
PORT(A, B: IN STD_LOGIC_VECTOR(255 DOWNTO 0);
		XOUT: OUT STD_LOGIC_VECTOR(255 DOWNTO 0));
END secp256k1_ModMult;

ARCHITECTURE arch OF secp256k1_ModMult IS
SIGNAL result: STD_LOGIC_VECTOR(511 DOWNTO 0);
BEGIN
	result <= (A * B);
	
	XOUT <= result(255 DOWNTO 0) WHEN result < P ELSE
				result(255 DOWNTO 0) - P;
END arch;

