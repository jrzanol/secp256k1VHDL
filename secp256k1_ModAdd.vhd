LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

LIBRARY work;
USE work.MYWORK.all;

ENTITY secp256k1_ModAdd IS
PORT(X1, X2: IN STD_LOGIC_VECTOR (255 DOWNTO 0);
		XOUT: OUT STD_LOGIC_VECTOR (255 DOWNTO 0));
END secp256k1_ModAdd;

ARCHITECTURE arch OF secp256k1_ModAdd IS
SIGNAL Xtmp: STD_LOGIC_VECTOR (255 DOWNTO 0);
BEGIN
	Xtmp <= (X1 + X2);
	XOUT <= Xtmp WHEN X1 < P ELSE (Xtmp - P);
END arch;

