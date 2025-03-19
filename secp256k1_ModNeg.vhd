LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

LIBRARY work;
USE work.MYWORK.all;

ENTITY secp256k1_ModNeg IS
PORT(X1: IN STD_LOGIC_VECTOR (255 DOWNTO 0);
		XOUT: OUT STD_LOGIC_VECTOR (255 DOWNTO 0));
END secp256k1_ModNeg;

ARCHITECTURE arch OF secp256k1_ModNeg IS
BEGIN
	XOUT <= (((NOT X1) + 1) + P);
END arch;

