library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for a 4-bit Ripple Carry Adder using full adder components
entity C4M1P3 is
    Port (
        a       : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input operand 'a'
        b       : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input operand 'b'
        cin     : in  STD_LOGIC;                    -- Carry-in for the least significant bit (LSB)
        s       : out STD_LOGIC_VECTOR(3 downto 0); -- 4-bit sum output
        cout    : out STD_LOGIC                     -- Carry-out from the most significant bit (MSB)
    );
end C4M1P3;

architecture Behavioral of C4M1P3 is
    -- Internal signals to propagate carry between the full adder stages
    signal carry : STD_LOGIC_VECTOR(3 downto 0); -- carry(0) to carry(2) are intermediate; final carry goes to 'cout'

    -- Component declaration for a single-bit full adder
    component full_adder
        Port (
            a   : in  STD_LOGIC;  -- 1-bit input from operand 'a'
            b   : in  STD_LOGIC;  -- 1-bit input from operand 'b'
            ci  : in  STD_LOGIC;  -- Carry-in for this bit
            s   : out STD_LOGIC;  -- Sum output for this bit
            c0  : out STD_LOGIC   -- Carry-out from this bit
        );
    end component;
    
begin
    -- First full adder: LSB addition with external carry-in
    FA0: full_adder port map (
        a => a(0),       -- LSB of operand a
        b => b(0),       -- LSB of operand b
        ci => cin,       -- External carry-in
        s => s(0),       -- Sum output for bit 0
        c0 => carry(0)   -- Carry-out goes to next stage
    );

    -- Second full adder: Adds second bit with carry from previous adder
    FA1: full_adder port map (
        a => a(1),
        b => b(1),
        ci => carry(0),
        s => s(1),
        c0 => carry(1)
    );

    -- Third full adder: Adds third bit with carry from second stage
    FA2: full_adder port map (
        a => a(2),
        b => b(2),
        ci => carry(1),
        s => s(2),
        c0 => carry(2)
    );

    -- Fourth full adder: MSB addition; final carry-out sent to output port 'cout'
    FA3: full_adder port map (
        a => a(3),
        b => b(3),
        ci => carry(2),
        s => s(3),
        c0 => cout
    );

end Behavioral;
