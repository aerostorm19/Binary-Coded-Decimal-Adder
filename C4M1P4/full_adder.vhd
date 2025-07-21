-- Import the IEEE standard logic library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Define the full_adder entity
entity full_adder is
    Port (
        a   : in  STD_LOGIC; -- 1-bit input a
        b   : in  STD_LOGIC; -- 1-bit input b
        ci  : in  STD_LOGIC; -- Carry-in input
        s   : out STD_LOGIC; -- Sum output bit
        c0  : out STD_LOGIC  -- Carry-out bit (goes to next stage in multi-bit adder)
    );
end full_adder;

-- Define the architecture (behavior) of the full adder
architecture Behavioral of full_adder is
begin
    -- Use a process block so logic updates whenever a, b, or ci change
    process(a, b, ci)
    begin
        -- The sum bit is the XOR of all three inputs
        -- Truth Table logic: 0+0+0=0, 1+0+0=1, 1+1+0=0, 1+1+1=1 etc.
        -- s = a ⊕ b ⊕ ci
        s   <= a xor b xor ci;

        -- Carry-out logic:
        -- A carry is generated when:
        -- - both a and b are 1: a AND b
        -- - OR when one of them is 1 and ci is also 1: ci AND (a XOR b)
        -- Combined as: c0 = (a AND b) OR (ci AND (a XOR b))
        c0  <= (a and b) or (ci and (a xor b));
    end process;
end Behavioral;
