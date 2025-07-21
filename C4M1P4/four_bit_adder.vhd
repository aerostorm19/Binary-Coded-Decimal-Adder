-- Import the IEEE standard logic library for digital logic types like STD_LOGIC and STD_LOGIC_VECTOR
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Define the entity 'four_bit_adder' which describes the input/output interface
entity four_bit_adder is
    Port (
        a     : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input operand A
        b     : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input operand B
        cin   : in  STD_LOGIC;                   -- Single-bit carry-in input
        s     : out STD_LOGIC_VECTOR(3 downto 0); -- 4-bit output sum
        cout  : out STD_LOGIC                    -- Final carry-out after addition
    );
end four_bit_adder;

-- Architecture defines the internal structure/behavior of the entity
architecture Behavioral of four_bit_adder is

    -- Internal carry chain between the 4 full adders
    signal carry : STD_LOGIC_VECTOR(3 downto 0);

    -- Declare a full adder component which takes in 2 bits + carry-in and outputs sum + carry-out
    component full_adder
        Port (
            a   : in  STD_LOGIC; -- 1-bit input from operand A
            b   : in  STD_LOGIC; -- 1-bit input from operand B
            ci  : in  STD_LOGIC; -- 1-bit carry-in from previous stage
            s   : out STD_LOGIC; -- 1-bit sum output
            c0  : out STD_LOGIC  -- 1-bit carry-out to next stage
        );
    end component;

begin
    -- Instantiate 4 full adders in series (ripple carry adder)
    -- FA0 handles LSB (bit 0) and takes external carry-in
    FA0: full_adder port map (a(0), b(0), cin, s(0), carry(0));
    
    -- FA1 adds the second bits and uses carry from FA0
    FA1: full_adder port map (a(1), b(1), carry(0), s(1), carry(1));
    
    -- FA2 adds third bits and uses carry from FA1
    FA2: full_adder port map (a(2), b(2), carry(1), s(2), carry(2));
    
    -- FA3 adds MSB (bit 3) and uses carry from FA2. Its carry-out is final output
    FA3: full_adder port map (a(3), b(3), carry(2), s(3), cout);

end Behavioral;
