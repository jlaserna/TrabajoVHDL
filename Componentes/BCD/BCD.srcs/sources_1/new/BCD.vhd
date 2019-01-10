library IEEE;
use IEEE.std_logic_1164.all;

entity BCD is
    port ( 
            code : in std_logic_vector (1 downto 0);
            led : out std_logic_vector (6 downto 0);
            display: out std_logic_vector (3 downto 0)
    );
end BCD;

architecture Behavioral of BCD is

begin
    with code select
        led <=  "0000001" when "00",
                "1001111" when "01",
                "0010010" when "10",
                "0000110" when "11",
                "1111110" when others;
        
    with code select
        display <= "0001" when "00",
                   "0010" when "01",
                   "0100" when "10",
                   "1000" when "11",
                   "0000" when others;

end Behavioral;
