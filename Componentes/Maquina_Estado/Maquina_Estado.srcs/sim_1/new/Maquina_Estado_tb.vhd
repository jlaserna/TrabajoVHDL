
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Maquina_Estado_tb is
end Maquina_Estado_tb;

architecture Behavioral of Maquina_Estado_tb is

 component Maquina_Estado
    port(
        clk : in std_logic;
        reset : in std_logic;
        piso_deseado : in std_logic_vector (1 downto 0);
        piso_nuevo : out std_logic_vector (1 downto 0);
        puerta: out std_logic;
        motor: out std_logic_vector(1 downto 0);
        tmp: out std_logic_vector(1 downto 0)
    );
    end component;

    signal clk: std_logic;
    signal piso_nuevo: std_logic_vector(1 downto 0);
    signal reset : std_logic := '0';
    signal piso_deseado : std_logic_vector(1 downto 0) := "00";
    signal puerta: std_logic := '1';
    signal motor: std_logic_vector(1 downto 0) := "00";
    signal tmp: std_logic_vector(1 downto 0) := "00";
    constant K: time := 10 ns;
begin

 uut: Maquina_Estado port map (
        clk => clk,
        reset => reset,
        piso_deseado => piso_deseado,
        piso_nuevo => piso_nuevo,
        puerta => puerta,
        motor => motor,
        tmp => tmp
        
    );

    --stim_proc1: process
    --begin
    --wait for 3*K;
    --reset<='1';
    --wait for 0.5*K;
    --reset<='0';
    --end process;
    
   stim_proc: process
   begin
        wait for 0.25 * K;
        clk <= '0';
        wait for 0.25 * K;
        clk <= '1';
    end process;
    
    stim_proc2: process
    begin
        wait for 5 * K;
        piso_deseado <= "01";
        wait for 5 * K;
        piso_deseado <= "10";
        wait for 5 * K;
        piso_deseado <= "11";
        wait for 5 * K;
        piso_deseado <= "00";
    end process;
    
    stim_proc3: process
    begin
    wait until piso_nuevo = "01";
    wait until piso_nuevo = "10";
    wait until piso_nuevo = "11";
    wait until piso_nuevo = "00";
    wait until piso_nuevo = "01";
    wait until piso_nuevo = "11";
    

    assert false
    report "Simulation finished."
    severity failure;
end process;

end Behavioral;
