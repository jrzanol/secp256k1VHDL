LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

LIBRARY work;
USE work.MYWORK.all;

ENTITY secp256k1_AddOnePoint IS
PORT(Clock, Reset: IN STD_LOGIC;
		X1, Y1: IN STD_LOGIC_VECTOR (255 DOWNTO 0);
		XOUT, YOUT: OUT STD_LOGIC_VECTOR (255 DOWNTO 0);
		SignalOut: OUT STD_LOGIC);
END secp256k1_AddOnePoint;

ARCHITECTURE arch OF secp256k1_AddOnePoint IS
SIGNAL deltaX, deltaY, lambda, lambda2, X2, Y2: STD_LOGIC_VECTOR (255 DOWNTO 0);
SIGNAL invDeltaX, tmpX, tmpX2, tmpY, tmpY2, tmpY3: STD_LOGIC_VECTOR (255 DOWNTO 0);
BEGIN
	X2 <= Gx;
	Y2 <= Gy;
	
	SUBDELTAX: secp256k1_ModSub PORT MAP(X2, X1, deltaX);
	SUBDELTAY: secp256k1_ModSub PORT MAP(Y2, Y1, deltaY);
	MULTLAMBDA: secp256k1_ModMult PORT MAP(deltaY, invDeltaX, lambda);
	MULTLAMBDA2: secp256k1_ModMult PORT MAP(lambda, lambda, lambda2);
	
	SUBLAMBDAX1: secp256k1_ModSub PORT MAP(lambda2, X1, tmpX);
	SUBLAMBDAX2: secp256k1_ModSub PORT MAP(tmpX, X2, tmpX2);
	SUBLAMBDAY1: secp256k1_ModSub PORT MAP(X1, tmpX2, tmpY);
	MULTLAMBDAY: secp256k1_ModMult PORT MAP(lambda, tmpY, tmpY2);
	SUBLAMBDAY2: secp256k1_ModSub PORT MAP(tmpY2, Y1, tmpY3);
	
	XOUT <= tmpX2;
	YOUT <= tmpY3;
END arch;

