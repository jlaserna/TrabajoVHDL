library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_tb is
end BCD_tb;

architecture Behavioral of BCD_tb is
component BCD
    port(
        code : in std_logic_vector(1 downto 0);
        led : out std_logic_vector(6 downto 0);
        display : out std_logic_vector(3 downto 0)
    );
end component;

signal code : std_logic_vector(1 downto 0):="00";
signal led : std_logic_vector(6 downto 0):="0000000";
signal display : std_logic_vector(3 downto 0):="0000";
constant K: time := 10 ns;



begin
    uut: BCD port map(
        code => code,
        led => led,
        display=> display
    );
    
   



tb_1:process
begin
    wait for 1 * K;
    code <= "00";
    wait for 1 * K;
    code <= "01";
    wait for 1 * K;
    code <= "10";
    wait for 1 * K;
    code <= "11";
end process;

stim_proc3: process
    begin
    wait until display = "11";
  
    assert false
    report "Simulation finished."
    severity failure;
end process;
end Behavioral;
