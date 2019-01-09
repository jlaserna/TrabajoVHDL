

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Maquina_Estado is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           piso_deseado : in STD_LOGIC_VECTOR (1 downto 0);
           piso_nuevo : out STD_LOGIC_VECTOR (1 downto 0));
end Maquina_Estado;

architecture Behavioral of Maquina_Estado is
    TYPE state_type is (S0, S1, S2, S3);
    SIGNAL state, next_state : state_type;
    
begin

 SYNC_PROC: PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF (reset = '1') THEN
                state <= S0;
            ELSE
                state <= next_state;
            END IF;
        END IF;
    END PROCESS;
    
    OUTPUT_DECODE: PROCESS (state)
    BEGIN
        CASE (state) is
            WHEN S0 => piso_nuevo <= "00";
            WHEN S1 => piso_nuevo <= "01";
            WHEN S2 => piso_nuevo <= "10";
            WHEN S3 => piso_nuevo <= "11";
            WHEN OTHERS => piso_nuevo <= "00";
        END CASE;
    END PROCESS;
    
    NEXT_STATE_DECODE: PROCESS (state, piso_deseado)
    BEGIN
        next_state <= S0;
        CASE (state) is
        
            WHEN S0 =>
                IF (piso_deseado = "00") THEN
                    next_state <= S0;
                ELSIF (piso_deseado = "01") THEN
                    next_state <= S1;
                ELSIF (piso_deseado = "10") THEN
                    next_state <= S2;
                ELSIF (piso_deseado = "11") THEN
                    next_state <= S3;    
                END IF;
                
            WHEN S1 =>
              IF (piso_deseado = "00") THEN
                    next_state <= S0;
              ELSIF (piso_deseado = "01") THEN
                    next_state <= S1;
              ELSIF (piso_deseado = "10") THEN
                    next_state <= S2;
              ELSIF (piso_deseado = "11") THEN
                    next_state <= S3;    
              END IF;
              
            WHEN S2 =>
              IF (piso_deseado = "00") THEN
                    next_state <= S0;
              ELSIF (piso_deseado = "01") THEN
                    next_state <= S1;
              ELSIF (piso_deseado = "10") THEN
                    next_state <= S2;
              ELSIF (piso_deseado = "11") THEN
                    next_state <= S3;    
              END IF;
              
            WHEN S3 =>
              IF (piso_deseado = "00") THEN
                    next_state <= S0;
              ELSIF (piso_deseado = "01") THEN
                    next_state <= S1;
              ELSIF (piso_deseado = "10") THEN
                    next_state <= S2;
              ELSIF (piso_deseado = "11") THEN
                    next_state <= S3;
              END IF;
            
        END CASE;
    END PROCESS;

end Behavioral;
