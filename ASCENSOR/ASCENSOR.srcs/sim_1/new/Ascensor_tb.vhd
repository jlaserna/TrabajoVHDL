
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Ascensor_tb is
end Ascensor_tb;

architecture Behavioral of Ascensor_tb is

 component Ascensor
    Port ( 
            clk : in std_logic;
            reset : in std_logic;
            piso_deseado : in std_logic_vector (3 downto 0);
            puerta_abierta : out std_logic_vector (1 downto 0);
            display_number : out std_logic_vector (6 downto 0);
            display_selection : out std_logic_vector (7 downto 0);
            motor_puerta : out std_logic_vector (1 downto 0)
      );
    end component;

    signal clk: std_logic;
    signal display_number: std_logic_vector(6 downto 0);
    signal display_selection: std_logic_vector(7 downto 0);
    signal reset : std_logic := '1';
    signal piso_deseado : std_logic_vector(3 downto 0) := "0000";
    signal puerta_abierta: std_logic_vector (1 downto 0);
    signal motor_puerta: std_logic_vector(1 downto 0) := "00";
    constant K: time := 10 ns;
begin

 uut: Ascensor port map (
        clk => clk,
        reset => reset,
        piso_deseado => piso_deseado,
        display_number => display_number,
        display_selection => display_selection,
        puerta_abierta => puerta_abierta,
        motor_puerta => motor_puerta
        
    );

   stim_proc: process
   begin
        wait for 0.25 * K;
        clk <= '0';
        wait for 0.25 * K;
        clk <= '1';
    end process;
    
    stim_proc2: process
        begin
        wait for 4 * K;
        piso_deseado <= "0010";
        wait for 4 * K;
        piso_deseado <= "1000";
        wait for 4 * K;
        piso_deseado <= "0100";
        wait for 4 * K;
        piso_deseado <= "0001";
        wait for 4 * K;
        piso_deseado <= "1000";
        wait for 4 * K;
        piso_deseado <= "0100";
        wait for 4 * K;
        piso_deseado <= "0001";
        wait for 4 * K;
        piso_deseado <= "0001";
        wait for 4 * K;
    end process;
    
    stim_proc3: process
    begin
        wait until display_number = "1001111";
        wait until display_number = "0000110";
        wait until display_number = "0010010";
        wait until display_number = "0000001";
        wait until display_number = "0000110";
        wait until display_number = "0000001";

    

    assert false
    report "Simulation finished."
    severity failure;
end process;

end Behavioral;
