library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- This is a Full Adder module
-- It adds two single-bit binary numbers (a and b) and a carry-in (ci)
-- and produces a sum bit (s) and a carry-out bit (c0)

entity full_adder is
    Port (
        a   : in  STD_LOGIC;  -- Single-bit input A
        b   : in  STD_LOGIC;  -- Single-bit input B
        ci  : in  STD_LOGIC;  -- Carry-in from the previous bit
        s   : out STD_LOGIC;  -- Output sum bit
        c0  : out STD_LOGIC   -- Output carry-out to the next stage
    );
end full_adder;

architecture Behavioral of full_adder is
begin
    -- The process block triggers whenever a, b, or ci change
    process(a, b, ci)
    begin
        -- XOR is used to calculate the sum of the three inputs
        s   <= a xor b xor ci;

        -- Carry-out logic: produces '1' if any two or more inputs are '1'
        -- This equation is standard for carry-out in a full adder
        c0  <= (a and b) or (ci and (a xor b));
    end process;
end Behavioral;
