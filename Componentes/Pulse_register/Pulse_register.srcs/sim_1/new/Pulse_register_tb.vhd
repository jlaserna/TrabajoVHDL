library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Pulse_register_tb is
end Pulse_register_tb;

architecture Behavioral of Pulse_register_tb is

 component Pulse_register
    port(
        clk : in std_logic;
        reset : in std_logic;
        boton : in std_logic_vector(3 downto 0);
        piso_deseado: out std_logic_vector(1 downto 0);
        moviendo : in std_logic := '0'
    );
    end component;

    signal clk : std_logic;
    signal reset : std_logic := '1';
    signal boton : std_logic_vector(3 downto 0) := "0000";
    signal piso_deseado: std_logic_vector(1 downto 0);
    signal moviendo : std_logic := '0';
    constant K: time := 10 ns;
begin

 uut: Pulse_register port map (
        clk => clk,
        reset => reset,
        boton => boton,
        piso_deseado => piso_deseado,
        moviendo => moviendo    
    );
  
   stim_proc: process
   begin
        wait for 0.5 * K;
        clk <= '0';
        wait for 0.5 * K;
        clk <= '1';
    end process;
    
    stim_proc2: process
    begin
        wait for 1 * K;
        boton <= "1000";
        wait for 1 * K;
        boton <= "0010";
        wait for 1 * K;
        boton <= "0100";
        wait for 1 * K;
        boton <= "1000";
        reset <= '0';
        wait for 1 * K;
        boton <= "0001";
        wait for 1 * K;
        boton <= "1000";
        wait for 1 * K;
        boton <= "0010";
                                                        

    end process;
    
    stim_proc3: process
    begin
    wait until piso_deseado = "00";
    wait until piso_deseado = "01";
    wait until piso_deseado = "10";
    wait until piso_deseado = "11";
    wait until piso_deseado = "00";
    wait until piso_deseado = "00";
    wait until piso_deseado = "01";
    wait until piso_deseado = "10";
    wait until piso_deseado = "11";
    wait until piso_deseado = "00";

    assert false
    report "Simulation finished."
    severity failure;
end process;

end Behavioral;

