library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration: Inputs and outputs
entity C4M1P2 is
    Port (
        SW   : in  STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit binary input V (from SW3-0)
        HEX1 : out STD_LOGIC_VECTOR (6 downto 0);  -- 7-segment output for digit d1 (MSB)
        HEX0 : out STD_LOGIC_VECTOR (6 downto 0)   -- 7-segment output for digit d0 (LSB)
    );
end C4M1P2;

architecture Behavioral of C4M1P2 is

    -- Internal signals
    signal V  : STD_LOGIC_VECTOR (3 downto 0);  -- Input value
    signal A  : STD_LOGIC_VECTOR (3 downto 0);  -- Output of logic circuit A (used if V > 9)
    signal z  : STD_LOGIC;                      -- Comparator output (1 if V > 9)
    signal d0 : STD_LOGIC_VECTOR (3 downto 0);  -- Lower digit for display
    signal d1 : STD_LOGIC_VECTOR (3 downto 0);  -- Upper digit for display

begin

    -- Assign input value
    V <= SW;

    -- Comparator logic: z = 1 if V > 9 (1001)
    z <= '1' when V > "1001" else '0';

    -- Circuit A logic: output a corrected digit if V > 9
    A(3) <= '0';
    A(2) <= V(1) and V(2);
    A(1) <= not V(1);
    A(0) <= V(0);

    -- Use V directly if z = 0, otherwise use A
    d0 <= V when z = '0' else A;
    d1 <= "0000" when z = '0' else "0001";  -- Show '1' in HEX1 only when V > 9

    -- HEX1 display (only 0 or 1)
    HEX1 <= "1000000" when d1 = "0000" else "1111001"; -- 0 or 1

    -- HEX0 display for d0 values (0 to 9)
    HEX0 <=
        "1000000" when d0 = "0000" else -- 0
        "1111001" when d0 = "0001" else -- 1
        "0100100" when d0 = "0010" else -- 2
        "0110000" when d0 = "0011" else -- 3
        "0011001" when d0 = "0100" else -- 4
        "0010010" when d0 = "0101" else -- 5
        "0000010" when d0 = "0110" else -- 6
        "1111000" when d0 = "0111" else -- 7
        "0000000" when d0 = "1000" else -- 8
        "0011000" when d0 = "1001" else -- 9
        "0000000";                       -- Default (fallback to 0)

end Behavioral;
