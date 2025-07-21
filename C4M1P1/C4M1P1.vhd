-- Import IEEE standard libraries for digital design
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;       -- Defines basic logic types (std_logic, std_logic_vector)
use IEEE.STD_LOGIC_ARITH.ALL;      -- (Non-standard, but sometimes used for arithmetic)
use IEEE.STD_LOGIC_UNSIGNED.ALL;   -- (Non-standard, treats std_logic_vector as unsigned numbers)

-- Entity declaration: defines the module name and I/O ports
entity C4M1P1 is
    Port (
        SW   : in  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit input from switches SW7 to SW0
        HEX0 : out STD_LOGIC_VECTOR(6 downto 0);  -- Output to 7-segment display HEX0
        HEX1 : out STD_LOGIC_VECTOR(6 downto 0)   -- Output to 7-segment display HEX1
    );
end C4M1P1;

-- Architecture describes the internal behavior of the module
architecture Behavioral of C4M1P1 is

    -- Function to convert a 4-bit BCD value into a 7-segment code
    -- Each segment of the display is mapped to a bit in the 7-bit output
    function BCD_to_7seg(bcd : in STD_LOGIC_VECTOR(3 downto 0)) return STD_LOGIC_VECTOR is
    begin
        case bcd is
            when "0000" => return "0111111"; -- Displays 0
            when "0001" => return "0000110"; -- Displays 1
            when "0010" => return "1011011"; -- Displays 2
            when "0011" => return "1001111"; -- Displays 3
            when "0100" => return "1100110"; -- Displays 4
            when "0101" => return "1101101"; -- Displays 5
            when "0110" => return "1111101"; -- Displays 6
            when "0111" => return "0000111"; -- Displays 7
            when "1000" => return "1111111"; -- Displays 8
            when "1001" => return "1101111"; -- Displays 9
            when others => return "0000000"; -- For undefined inputs, display nothing (all segments off)
        end case;
    end function;

begin

    -- HEX0 shows the lower 4 bits (SW3 to SW0) of the switch input
    HEX0 <= BCD_to_7seg(SW(3 downto 0));

    -- HEX1 shows the upper 4 bits (SW7 to SW4) of the switch input
    HEX1 <= BCD_to_7seg(SW(7 downto 4));

end Behavioral;
