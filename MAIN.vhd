LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MAIN IS
PORT(PrivateKey: IN STD_LOGIC_VECTOR (255 DOWNTO 0);
		PublicKey: OUT STD_LOGIC_VECTOR (32 DOWNTO 0));
END MAIN;

ARCHITECTURE arch OF MAIN IS
BEGIN

PROCESS(PrivateKey)
BEGIN
END PROCESS;

END arch;

