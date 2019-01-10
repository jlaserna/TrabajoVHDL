library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Pulse_register is
    Port ( clk : in std_logic;
           reset : in std_logic;
           boton : in std_logic_vector(3 downto 0);
           piso_deseado: out std_logic_vector(1 downto 0)
    );
end Pulse_register;

architecture Behavioral of Pulse_register is
    type state_type is (S0, S1, S2, S3);
    signal state, next_state : state_type;
    
begin

    SYNC_PROC: process (clk)
    begin
        if rising_edge(clk) then
            if (reset = '0') then
                state <= S0;
            else
                state <= next_state;
            end if;
        end if;
    end process;

    OUTPUT_DECODE: process (state)
    begin
        case (state) is
            when S0 => piso_deseado <= "00";
            when S1 => piso_deseado <= "01";
            when S2 => piso_deseado <= "10";
            when S3 => piso_deseado <= "11";
            when others => piso_deseado <= "00";
        end case;
    end process;
    
    NEXT_STATE_DECODE: process (state, boton)
    begin
        next_state <= state;
        case (state) is
            
            when S0 =>
                if(boton = "0001") then 
                    next_state <= S0;
                elsif(boton = "0010") then
                    next_state <= S1;
                elsif(boton = "0100") then
                    next_state <= S2;
                elsif(boton = "1000") then
                    next_state <= S3;
                end if;
                
            when S1 =>
                if(boton = "0001") then 
                    next_state <= S0;
                elsif(boton = "0010") then
                    next_state <= S1;
                elsif(boton = "0100") then
                    next_state <= S2;
                elsif(boton = "1000") then
                    next_state <= S3;
                end if;

            when S2 =>
                if(boton = "0001") then 
                    next_state <= S0;
                elsif(boton = "0010") then
                    next_state <= S1;
                elsif(boton = "0100") then
                    next_state <= S2;
                elsif(boton = "1000") then
                    next_state <= S3;
                end if;
            
            when S3 =>
                if(boton = "0001") then 
                    next_state <= S0;
                elsif(boton = "0010") then
                    next_state <= S1;
                elsif(boton = "0100") then
                    next_state <= S2;
                elsif(boton = "1000") then
                    next_state <= S3;
                end if;
        end case;
    end process;
    
end Behavioral;