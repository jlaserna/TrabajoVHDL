library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_tb is
end BCD_tb;

architecture Behavioral of BCD_tb is
component BCD
    port(
        code : in std_logic_vector(3 downto 0);
        led : out std_logic_vector(6 downto 0)
    );
end component;

signal code : std_logic_vector(3 downto 0);
signal led : std_logic_vector(6 downto 0);

type vtest is record
    code : std_logic_vector(3 downto 0);
    led : std_logic_vector(6 downto 0);
end record;

type vtest_vector is array (natural range <>) of vtest;

constant test: vtest_vector := (
        (code => "0000", led => "0000001"),
        (code => "0001", led => "1001111"),
        (code => "0010", led => "0010010"),
        (code => "0011", led => "0000110"),
        (code => "0100", led => "1001100"),
        (code => "0101", led => "0100100"),
        (code => "0110", led => "0100000"),
        (code => "0111", led => "0001111"),
        (code => "1000", led => "0000000"),
        (code => "1001", led => "0000100"),
        (code => "1010", led => "1111110"),
        (code => "1011", led => "1111110"),
        (code => "1100", led => "1111110"),
        (code => "1101", led => "1111110"),
        (code => "1110", led => "1111110"),
        (code => "1111", led => "1111110")
);

begin
    uut: BCD port map(
        code => code,
        led => led
    );
    
    tb: process
    begin
        for i in 0 to test'HIGH loop
            code <= test(i).code;
            wait for 20 ns;
            assert led = test(i).led
                report "Salida incorrecta."
                severity FAILURE;
        end loop;
        assert false
        report "Simulacin finalizada. Test superado."
        severity FAILURE;
    end process;

end Behavioral;
