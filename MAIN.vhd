LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

LIBRARY work;
USE work.MYWORK.all;

ENTITY MAIN IS
PORT(CLK, RESET: IN STD_LOGIC;
		PublicKey: OUT STD_LOGIC_VECTOR (263 DOWNTO 0));
END MAIN;

ARCHITECTURE arch OF MAIN IS
SIGNAL CurrentX, CurrentY : STD_LOGIC_VECTOR (255 DOWNTO 0) := (OTHERS => '0');
SIGNAL OutX, OutY : STD_LOGIC_VECTOR (255 DOWNTO 0) := (OTHERS => '0');
SIGNAL CurrentSignal : STD_LOGIC := '0';

BEGIN
	PROCESS (CLK, RESET, CurrentSignal)
	BEGIN
		IF RESET = '1' THEN
			CurrentX <= Gx;
			CurrentY <= Gy;
		ELSIF rising_edge(CLK) THEN
			IF CurrentSignal = '1' THEN
				CurrentX <= OutX;
				CurrentY <= OutY;
			END IF;
		END IF;
	END PROCESS;

calcPk: secp256k1_AddOnePoint PORT MAP(CLK, RESET, CurrentX, CurrentY, OutX, OutY, CurrentSignal);

	PublicKey <= ("00000010" OR ("0000000" & CurrentY(0))) & CurrentX;
END arch;

