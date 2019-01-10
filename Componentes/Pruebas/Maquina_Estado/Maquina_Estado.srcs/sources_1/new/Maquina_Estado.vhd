library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Maquina_Estado is
    port ( clk : in std_logic;
           reset : in std_logic;
           piso_deseado : in std_logic_vector (1 downto 0);
           piso_nuevo : out std_logic_vector (1 downto 0);
           puerta: out std_logic;
           motor: out std_logic_vector(1 downto 0);
           tmp: out std_logic_vector(1 downto 0)
         );
end Maquina_Estado;

architecture Behavioral of Maquina_Estado is
    type state_type is (S0, S1, S2, S3);
    signal state, next_state : state_type;
    signal temp : std_logic_vector (1 downto 0);
    signal moviendo : std_logic := '0';
    
begin

 SYNC_PROC: process (clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                state <= S0;
            else
                state <= next_state;
            end if;
        end if;
    end process;
    
    OUTPUT_DECODE: process (state)
    begin
        case (state) is
            when S0 => piso_nuevo <= "00";
            when S1 => piso_nuevo <= "01";
            when S2 => piso_nuevo <= "10";
            when S3 => piso_nuevo <= "11";
            when others => piso_nuevo <= "00";
        end case;
    end process;
    
    OUTPUTDECODE: process (temp)
        begin
            case (temp) is
                when "00" => tmp <= "00";
                when "01" => tmp <= "01";
                when "10" => tmp <= "10";
                when "11" => tmp <= "11";
                when others => tmp <= "00";
            end case;
        end process;
    
    NEXT_STATE_DECODE: process (state, piso_deseado, clk)
    begin
     
        case (state) is
        
          when S0 =>
              if (moviendo = '1' and temp = "00") then
                    next_state <= S0;
                    moviendo <= not moviendo;
                    puerta<='1';
                    motor<="00";
               elsif (piso_deseado = "00") then
                  next_state <= S0;
                  puerta<='1';
                  motor<="00";
                  moviendo <= '0';
                  temp <= "00";
              elsif (piso_deseado /= "00") and (moviendo /= '1') then
                  puerta<='0';
                  motor<="01";
                  next_state <= S1;
                  moviendo <= '1';
                  temp <= piso_deseado;
              end if;
                      
          when S1 =>
              if (moviendo = '1' and temp = "01") then
                    next_state <= S1;
                    moviendo <= not moviendo;
                    puerta<='1';
                    motor<="00";
               elsif (temp /= "01") then 
                 if(temp = "10") or (temp = "11") then
                     next_state <= S2;
                     motor<="01";
                 elsif(temp = "00") then
                     next_state <= S0;
                     motor<="10";
                 end if;
                 puerta<='0';
                 moviendo <= '1';
              else 
                 if (piso_deseado = "00") then
                     next_state <= S0;
                     puerta<='0';
                     moviendo <= '1';
                     motor<="10";
                     temp <= "00";
                 elsif (piso_deseado = "01") then
                     next_state <= S1;
                     puerta<='1';
                     motor<="00";
                     temp <= "01";
                 elsif (piso_deseado = "10") then
                     next_state <= S2;
                     puerta<='0';
                     moviendo <= '1';
                     motor<="01";
                     temp <= "10";
                 elsif (piso_deseado = "11") then
                     next_state <= S2;
                     temp <= piso_deseado;
                     puerta<='0';
                     moviendo <= '1';
                     motor<="01";
                 end if;
             end if;
                     
         when S2 =>
             if (moviendo = '1' and temp = "10") then
                  next_state <= S2;
                  moviendo <= not moviendo;
                  puerta<='1';
                  motor<="00";
             elsif (temp /= "10") then 
               if(temp = "00") or (temp = "01") then
                   next_state <= S1;
                   motor<="10";
               elsif(temp = "11") then
                    next_state <= S3;
                    motor<="01";
               end if;
               puerta<='0';
               moviendo <= '1';
             else 
               if (piso_deseado = "00") then
                    next_state <= S1;
                    temp <= piso_deseado;
                    puerta<='0';
                    moviendo <= '1';
                    motor<="10";
               elsif (piso_deseado = "01") then
                    next_state <= S1;
                    puerta<='0';
                    moviendo <= '1';
                    motor<="10";
                    temp <= "01";
               elsif (piso_deseado = "10") then
                    next_state <= S2;
                    puerta<='1';
                    motor<="00";
                    temp <= "10";
               elsif (piso_deseado = "11") then
                    next_state <= S3;
                    puerta<='0';
                    moviendo <= '1';
                    motor<="01";
                    temp <= "11";
               end if;
            end if;
                     
         when S3 =>
            if (moviendo = '1' and temp = "11") then
                 next_state <= S3;
                 moviendo <= not moviendo;
                 puerta<='1';
                 motor<="00";
            elsif (piso_deseado = "11") then
                next_state <= S3;
                puerta<='1';
                motor<="00";
            elsif (piso_deseado /= "11") and (moviendo /= '1') then
                puerta<='0';
                motor<="10";
                next_state <= S2;
                moviendo <= '1';
                temp <= piso_deseado;
            end if;           
            
        end case;
    end process;

end Behavioral;
