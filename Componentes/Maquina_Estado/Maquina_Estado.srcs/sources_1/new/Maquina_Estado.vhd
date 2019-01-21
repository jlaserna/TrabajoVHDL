---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--                             SISTEMAS ELECTRÓNICOS DIGITALES                                   --
--                                  TRABAJO VHDL ASCENSOR                                        --
--                                     CURSO 2018/2019                                           --
--                                                                                               --
--                                                                                               --
--  AUTORES:                                                                                     --
--      JAVIER LASERNA MORATALLA Nº52431                                                         --
--      ALEJANDRO MORA SÁNCHEZ Nº52496                                                           --
--      LUIS PEDRERO MORCILLO Nº52541                                                            --
--                                                                                               --
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--                                                                                               --
--      COMPONENTE: MÁQUINA DE ESTADO                                                            --
--                                                                                               --
--                                                                                               --
--  IMPLEMENTACIÓN DEL CÓDIGO CORRESPONDIENTE A LA MÁQUINA DE ESTADO                             --
--      ENTRADAS: clk, reset (std_logic)                                                         --
--                piso_deseado (std_logic_vector)                                                --
--      SALIDAS: moviendo (std_logic)                                                            --
--               piso_nuevo, puerta, motor (std_logic_vector)                                    --
--                                                                                               --
--      FUNCIONAMIENTO:                                                                          --
--                                                                                               --
--         El objetivo de la máquina de estados es determinar el piso del ascensor en el que     --
--         se encuentra, si la puerta está abierta o cerrada y si el ascensor sube o baja.       --
--         Se disponen de 4 pisos por lo que tiene 4 estados: S0 para el piso 0,                 --
--         S1 para el piso 1, S2 para el piso 2, S3 para el piso 3. Por otro lado, se dispone    --
--         de una entrada la cual  determina si se produce cambio de estado o si se              --
--         permanece en el mismo (piso_deseado), una señal de reloj (clk) y un reset (reset).    --
--         En cuanto a las salidas cuenta con una la cual determina si la puerta está abierta    --
--         o cerrada (puerta) y otra que determina si el ascensor sube o baja de piso (motor).   --                                                                   --
--                                                                                               --
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------





library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Maquina_Estado is
    port ( clk : in std_logic;
           reset : in std_logic;
           piso_deseado : in std_logic_vector (1 downto 0);
           piso_nuevo : out std_logic_vector (1 downto 0);
           puerta: out std_logic_vector (1 downto 0);
           motor: out std_logic_vector(1 downto 0);
           moviendo: out std_logic
         );
end Maquina_Estado;

architecture Behavioral of Maquina_Estado is
    type state_type is (S0, S1, S2, S3);
    signal state, next_state : state_type;
    signal temp : std_logic_vector (1 downto 0);
    
begin

 SYNC_PROC: process (clk, reset)
    begin
        if (reset = '0') then
                state <= S0;
        elsif rising_edge(clk) then
            state <= next_state;
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
    
    NEXT_STATE_DECODE: process (state, piso_deseado)
    begin
        next_state <= S0;
        case (state) is
        
          when S0 =>
              if (piso_deseado = "00") then
                  next_state <= S0;
                  puerta<="10";
                  motor<="00";
                  moviendo<='0';
              elsif (piso_deseado /= "00") then
                  puerta<="01";
                  motor<="01";
                  next_state <= S1;
                  temp <= piso_deseado;
                  moviendo<='1';
              end if;
                      
          when S1 =>
              if (temp /= "01") then 
                 if(temp = "10") or (temp = "11") then
                     next_state <= S2;
                     motor<="01";
                 elsif(temp = "00") then
                     next_state <= S0;
                     motor<="10";
                 end if;
                 puerta<="01";
                 moviendo<='1';
              else 
                 if (piso_deseado = "00") then
                     next_state <= S0;
                     puerta<="01";
                     motor<="10";
                     temp <= "00";
                     moviendo<='1';
                 elsif (piso_deseado = "01") then
                     next_state <= S1;
                     puerta<="10";
                     motor<="00";
                     temp <= "01";
                     moviendo<='0';
                 elsif (piso_deseado = "10") then
                     next_state <= S2;
                     puerta<="01";
                     motor<="01";
                     temp <= "10";
                     moviendo<='1';
                 elsif (piso_deseado = "11") then
                     next_state <= S2;
                     temp <= piso_deseado;
                     puerta<="01";
                     motor<="01";
                     moviendo<='1';
                 end if;
             end if;
                     
         when S2 =>
             if (temp /= "10") then 
               if(temp = "00") or (temp = "01") then
                   next_state <= S1;
                   motor<="10";
               elsif(temp = "11") then
                    next_state <= S3;
                    motor<="01";
               end if;
               puerta<="01";
               moviendo<='1';
             else 
               if (piso_deseado = "00") then
                    next_state <= S1;
                    temp <= piso_deseado;
                    puerta<="01";
                    motor<="10";
                    moviendo<='1';
               elsif (piso_deseado = "01") then
                    next_state <= S1;
                    puerta<="01";
                    motor<="10";
                    temp <= "01";
                    moviendo<='1';
               elsif (piso_deseado = "10") then
                    next_state <= S2;
                    puerta<="10";
                    motor<="00";
                    temp <= "10";
                    moviendo<='0';
               elsif (piso_deseado = "11") then
                    next_state <= S3;
                    puerta<="01";
                    motor<="01";
                    temp <= "11";
                    moviendo<='1';
               end if;
            end if;
                     
         when S3 =>
            if (piso_deseado = "11") then
                next_state <= S3;
                puerta<="10";
                motor<="00";
                moviendo<='0';
            elsif (piso_deseado /= "11") then
                puerta<="01";
                motor<="10";
                next_state <= S2;
                temp <= piso_deseado;
                moviendo<='1';
            end if;           
            
        end case;
    end process;

end Behavioral;
