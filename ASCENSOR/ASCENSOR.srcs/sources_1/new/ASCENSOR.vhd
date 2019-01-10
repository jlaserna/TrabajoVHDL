library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ASCENSOR is
     Port ( clk : in std_logic;
            reset : in std_logic;
            piso_deseado : in std_logic_vector (1 downto 0);
            puerta_abierta : out std_logic;
            display_number : out std_logic_vector (6 downto 0);
            display_selection : out std_logic_vector (3 downto 0)
     );
end ASCENSOR;

architecture structural of ASCENSOR is
signal clk_sinc : std_logic;
signal piso_actual : std_logic_vector(1 downto 0);
     component Maquina_Estado is
     port ( clk : in std_logic;
            reset : in std_logic;
            piso_deseado : in std_logic_vector (1 downto 0);
            piso_nuevo : out std_logic_vector (1 downto 0);
            puerta: out std_logic;
            motor: out std_logic_vector(1 downto 0);
            tmp: out std_logic_vector(1 downto 0)
     );
     end component;
     
     component Clk_divider is
     port ( clk,reset: in std_logic;
            clk_out: out std_logic
     );
     end component;
     
     component BCD is
     port ( code : in std_logic_vector (3 downto 0);
            led : out std_logic_vector (6 downto 0)
     );
     end component;
      
begin
     inst_Maquina_Estado: Maquina_Estado port map(
        clk=>clk_sinc,
        reset=>reset,
        piso_deseado=>piso_deseado,
        piso_nuevo=>piso_actual,
        puerta=>puerta_abierta
     );
     inst_Clk_divider: Clk_divider port map(
        clk=>clk,
        reset=>reset,
        clk_out=>clk_sinc
     );
     inst_BCD: BCD port map(
        led=>display_number,
        code=>piso_actual
     );
end;
