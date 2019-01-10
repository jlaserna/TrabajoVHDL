library IEEE;
use IEEE.std_logic_1164.all;

entity BCD is
    port ( 
            code : in std_logic_vector (3 downto 0);
            led : out std_logic_vector (6 downto 0)
    );
end BCD;

architecture Behavioral of BCD is

begin
    with code select
        led <=  "0000001" when "0000",
                "1001111" when "0001",
                "0010010" when "0010",
                "0000110" when "0011",
                "1001100" when "0100",
                "0100100" when "0101",
                "0100000" when "0110",
                "0001111" when "0111",
                "0000000" when "1000",
                "0000100" when "1001",
                "1111110" when others;

end Behavioral;
