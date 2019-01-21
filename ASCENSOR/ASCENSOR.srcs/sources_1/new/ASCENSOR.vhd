----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
--                             SISTEMAS ELECTRÓNICOS DIGITALES                                          --
--                                  TRABAJO VHDL ASCENSOR                                               --
--                                     CURSO 2018/2019                                                  --
--                                                                                                      --
--                                                                                                      --
--  AUTORES:                                                                                            --
--      JAVIER LASERNA MORATALLA Nº52431                                                                --
--      ALEJANDRO MORA SÁNCHEZ Nº52496                                                                  --
--      LUIS PEDRERO MORCILLO Nº52541                                                                   --
--                                                                                                      --
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
--                                                                                                      --
--      COMPONENTE: ASCENSOR                                                                            --
--                                                                                                      --
--                                                                                                      --
--  IMPLEMENTACIÓN DEL CÓDIGO CORRESPONDIENTE AL ASCENSOR                                               --
--      ENTRADAS: clk, reset, moviendo (std_logic)                                                      --
--                piso_deseado (std_logic_vector)                                                       --
--      SALIDAS:  puerta_abierta, display_number, display_selection, motor_puerta (std_logic_vector)    --
--                                                                                                      --
--      FUNCIONAMIENTO:                                                                                 --
--                                                                                                      --
--         El objetivo del módulo Ascensor es conectar cada uno de los distintos componentes            --
--         de forma que funcionen correctamente. Para ello se realizan instanciaciones de los           --
--         componentes máquina de estado, pulse register, clk divider y BCD; conectándo las             --
--         salidas y entradas mediante distintas señales.                                               --
--                                                                                                      --
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------






library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Ascensor is
     Port ( clk : in std_logic;
            reset : in std_logic;
            piso_deseado : in std_logic_vector (3 downto 0);
            puerta_abierta : out std_logic_vector (1 downto 0);
            display_number : out std_logic_vector (6 downto 0);
            display_selection : out std_logic_vector (7 downto 0);
            motor_puerta : out std_logic_vector (1 downto 0)
     );
end Ascensor;

architecture structural of Ascensor is
signal clk_sinc : std_logic;
signal piso_actual : std_logic_vector(1 downto 0);
signal piso_d : std_logic_vector (1 downto 0);
signal mov : std_logic;

     component Maquina_Estado is
     port ( clk : in std_logic;
            reset : in std_logic;
            piso_deseado : in std_logic_vector (1 downto 0);
            piso_nuevo : out std_logic_vector (1 downto 0);
            puerta: out std_logic_vector (1 downto 0);
            motor: out std_logic_vector(1 downto 0);
            moviendo: out std_logic
     );
     end component;
     
     component Pulse_register is
          port ( clk : in std_logic;
                 reset : in std_logic;
                 boton : in std_logic_vector(3 downto 0);
                 piso_deseado: out std_logic_vector(1 downto 0);
                 moviendo : in std_logic
          );
     end component;
          
     component Clk_divider is
     port ( clk,reset: in std_logic;
            clk_out: out std_logic
     );
     end component;
     
     component BCD is
     port ( code : in std_logic_vector (1 downto 0);
            led : out std_logic_vector (6 downto 0);
            display: out std_logic_vector (7 downto 0)
     );
     end component;
      
begin
     inst_Maquina_Estado: Maquina_Estado port map(
        clk => clk_sinc,
        reset => reset,
        piso_deseado => piso_d,
        piso_nuevo => piso_actual,
        puerta => puerta_abierta,
        motor => motor_puerta,
        moviendo => mov
     );
     inst_Pulse_register: Pulse_register port map(
        clk => clk,
        reset => reset,
        boton => piso_deseado,
        piso_deseado => piso_d,
        moviendo => mov
      );
     inst_Clk_divider: Clk_divider port map(
        clk => clk,
        reset => reset,
        clk_out => clk_sinc
     );
     inst_BCD: BCD port map(
        led => display_number,
        code => piso_actual,
        display => display_selection
     );
end;
