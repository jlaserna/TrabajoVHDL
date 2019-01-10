library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
 
entity Clk_divider is
    port ( 
    clk,reset: in std_logic;
    clk_out: out std_logic
    );
end Clk_divider;
 
architecture behavioral of Clk_divider is
 
signal count: integer:=1;
signal tmp : std_logic := '0';
 
begin
 
process(clk,reset)
    begin
        if(reset='0') then
            count<=1;
            tmp<='0';
        elsif(clk'event and clk='1') then
            count <=count+1;
            if (count = 200000000) then
                tmp <= NOT tmp;
                count <= 1;
            end if;
        end if;
    clk_out <= tmp;
end process;
 
end behavioral;