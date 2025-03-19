library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Biblioteca necessária para operações com unsigned

LIBRARY work;
USE work.MYWORK.all;

entity ModInverse is
    port (
        clk   : in  std_logic;  -- Clock
        rst   : in  std_logic;  -- Reset
        start : in  std_logic;  -- Sinal para iniciar a computação
        A     : in  std_logic_vector(255 downto 0);  -- Número a inverter
        done  : out std_logic;  -- Indica finalização do cálculo
        Inv   : out std_logic_vector(255 downto 0)  -- Resultado
    );
end ModInverse;

architecture Behavioral of ModInverse is
    type state_type is (INIT, LOOPFLAG, CHECK, FINALIZE, DONEFLAG);
    signal state : state_type := INIT;

    -- Declarando sinais como unsigned
    signal r, newR, t, newT, quotient, temp : unsigned(255 downto 0);

begin
    process (clk, rst)
    begin
        if rst = '1' then
            state <= INIT;
            done <= '0';
        elsif rising_edge(clk) then
            case state is
                when INIT =>
                    if start = '1' then
                        r <= unsigned(P);   -- Converte P para unsigned
                        newR <= unsigned(A);  -- Converte A para unsigned
                        t <= (others => '0');
                        newT <= (others => '1');
                        done <= '0';
                        state <= LOOPFLAG;
                    end if;

                when LOOPFLAG =>
                    if newR /= 0 then
                        quotient <= r / newR;  -- Agora pode ser feita a divisão corretamente
                        
                        -- Atualiza r e newR
                        temp <= newR;
                        newR <= r - (quotient * newR);
                        r <= temp;

                        -- Atualiza t e newT
                        temp <= newT;
                        newT <= t - (quotient * newT);
                        t <= temp;
                    else
                        state <= CHECK;
                    end if;

                when CHECK =>
                    if r /= 1 then
                        Inv <= (others => '0');  -- Sem inverso
                        done <= '1';
                        state <= DONEFLAG;
                    else
                        state <= FINALIZE;
                    end if;

                when FINALIZE =>
                    if t(255) = '1' then
                        t <= t + unsigned(P);
                    end if;
                    Inv <= std_logic_vector(t);  -- Converte de unsigned para std_logic_vector
                    done <= '1';
                    state <= DONEFLAG;

                when DONEFLAG =>
                    -- Aguarda novo start
                    if start = '0' then
                        state <= INIT;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;
