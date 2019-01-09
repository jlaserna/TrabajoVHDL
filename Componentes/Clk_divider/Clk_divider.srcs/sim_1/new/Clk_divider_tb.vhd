
library ieee;
use ieee.std_logic_1164.all;

entity Tb_clock_divider is
end Tb_clock_divider;

architecture behavioral of Tb_clock_divider is

component Clock_Divider
    port(
        clk : in std_logic;
        reset : in std_logic;
        clock_out : out std_logic
    );
end component;

signal clk : std_logic := '0';
signal reset : std_logic := '0';
signal clock_out : std_logic;
constant clk_period : time := 20 ns;

begin

    uut: Clock_Divider port map (
        clk => clk,
        reset => reset,
        clock_out => clock_out
    );

    clk_process :process
        begin
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
    end process;

    stim_proc: process
        begin
            wait for 100 ns;
            reset <= '1';
            wait for 100 ns;
            reset <= '0';
            wait;
    end process;

END;