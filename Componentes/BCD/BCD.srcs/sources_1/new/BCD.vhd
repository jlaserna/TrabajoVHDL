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
--      COMPONENTE: CONVERTIDOR BDC                                                              --
--                                                                                               --
--                                                                                               --
--  IMPLEMENTACIÓN DEL CÓDIGO CORRESPONDIENTE AL CONVERTIDOR BCD                                 --
--      ENTRADAS: code (std_logic_vector)                                                        --
--      SALIDAS: led, display (std_logic_vector)                                                 --
--                                                                                               --
--      FUNCIONAMIENTO:                                                                          --
--                                                                                               --
--         El objetivo del decodificador BCD de 7 segmentos es mostrar en el display             --
--         de la placa el número del piso en el que nos encontramos. Disponemos una entrada      --
--         (code) la cual recibe el piso en el que se encuentra el ascensor y dos salidas,       --
--         una para seleccionar cual, de los 8 dígitos de ambos display se enciende              --
--         (display); y otra para mostrar el número en decimal del piso en el que se             --
--         encuentra (led). Para ello, cada posible valor de la entrada, se lo asignamos a las   --
--         distintas opciones de salida que queremos lograr.                                     --
--                                                                                               --
--                                                                                               --
--                                                                                               --
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------




library IEEE;
use IEEE.std_logic_1164.all;

entity BCD is
    port ( 
            code : in std_logic_vector (1 downto 0);
            led : out std_logic_vector (6 downto 0);
            display: out std_logic_vector (7 downto 0)
    );
end BCD;

architecture Behavioral of BCD is

begin
    with code select
        led <=  "0000001" when "00",
                "1001111" when "01",
                "0010010" when "10",
                "0000110" when "11",
                "1111110" when others;
        
    with code select
        display <= "11111110" when "00",
                   "11111101" when "01",
                   "11111011" when "10",
                   "11110111" when "11",
                   "11111111" when others;

end Behavioral;
