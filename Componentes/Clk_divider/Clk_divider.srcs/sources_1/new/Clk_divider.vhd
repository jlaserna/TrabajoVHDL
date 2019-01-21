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
--      COMPONENTE: CLOCK DIVIDER (DIVISOR DE FRECUENCIA)                                        --
--                                                                                               --
--                                                                                               --
--  IMPLEMENTACIÓN DEL CÓDIGO CORRESPONDIENTE AL CLOCK DIVIDER                                   --
--      ENTRADAS: clk, reset (std_logic)                                                         --
--      SALIDAS: clk_out (std_logic)                                                             --
--                                                                                               --
--      FUNCIONAMIENTO:                                                                          --
--                                                                                               --
--         El objetivo del clock divider es es reducir la frecuencia con la que se produce       --
--         un pulso de reloj, es decir, crear una señal de reloj distinta a la del reloj de      --
--         la placa. Este clock divider genera una señal de reloj a la salida cada               --
--         200.000.000 pulsos del reloj de la placa.                                             --
--                                                                                               --
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
 
entity Clk_divider is
    port ( 
    clk,reset: in std_logic;
    clk_out: out std_logic
    );
end Clk_divider;
 
architecture behavioral of Clk_divider is
 
signal count: integer:=1;
signal tmp : std_logic := '0';
 
begin
 
process(clk,reset)
    begin
        if(reset='0') then
            count<=1;
            tmp<='0';
        elsif(clk'event and clk='1') then
            count <=count+1;
            if (count = 200000000) then
                tmp <= NOT tmp;
                count <= 1;
            end if;
        end if;
    clk_out <= tmp;
end process;
 
end behavioral;