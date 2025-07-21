-- Import IEEE standard libraries for logic and numeric operations
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entity declaration: I/O ports for switches, LEDs, and 7-segment displays
entity C4M1P5 is
    Port (
        SW    : in  STD_LOGIC_VECTOR (8 downto 0); -- SW8-SW0: Inputs for A[3:0], B[3:0], and Carry-in
        LEDR  : out STD_LOGIC_VECTOR (9 downto 0); -- LEDR9-0: Output indicators (e.g., result and error)
        HEX5  : out STD_LOGIC_VECTOR (6 downto 0); -- 7-seg for A
        HEX3  : out STD_LOGIC_VECTOR (6 downto 0); -- 7-seg for B
        HEX1  : out STD_LOGIC_VECTOR (6 downto 0); -- 7-seg for Carry-out (S1)
        HEX0  : out STD_LOGIC_VECTOR (6 downto 0)  -- 7-seg for BCD sum output (S0)
    );
end C4M1P5;

architecture Behavioral of C4M1P5 is

    -- Internal signal declarations
    signal A, B : STD_LOGIC_VECTOR (3 downto 0); -- 4-bit BCD operands
    signal cin  : STD_LOGIC;                     -- Carry-in
    signal T0   : UNSIGNED(4 downto 0);          -- Intermediate raw sum (max 5 bits for carry)
    signal Z0   : UNSIGNED(4 downto 0);          -- Will be set to 10 if T0 > 9, else 0
    signal S0   : STD_LOGIC_VECTOR (3 downto 0); -- Final 4-bit BCD sum
    signal S1   : STD_LOGIC;                     -- Final carry-out
    signal c1   : STD_LOGIC;                     -- Carry check signal
    signal SubResult : UNSIGNED(4 downto 0);     -- T0 - Z0 result, intermediate

begin

    -- Map switch inputs to internal signals
    A   <= SW(7 downto 4);  -- Upper 4 bits are A
    B   <= SW(3 downto 0);  -- Lower 4 bits are B
    cin <= SW(8);           -- MSB is the carry-in

    -- Step 1: Compute raw binary sum with 5-bit precision (to include carry)
    T0 <= ('0' & UNSIGNED(A)) + ('0' & UNSIGNED(B)) + ("0000" & cin);

    -- Step 2-8: Check for BCD overflow (T0 > 9) and correct it
    process(T0)
    begin
        if T0 > 9 then
            Z0 <= "01010";  -- Decimal 10 in binary
            c1 <= '1';      -- Carry-out gets triggered
        else
            Z0 <= "00000";  -- No correction needed
            c1 <= '0';      -- No carry
        end if;
    end process;

    -- Step 9: Adjust sum to valid BCD by subtracting 10 if overflow occurred
    SubResult <= T0 - Z0;
    S0 <= STD_LOGIC_VECTOR(SubResult(3 downto 0)); -- Trim result to 4 bits and convert to std_logic_vector

    -- Step 10: Assign carry-out
    S1 <= c1;

    -- Step 11: Check for invalid BCD input (greater than 9), light up LEDR9 if invalid
    LEDR(9) <= '1' when (A > "1001") or (B > "1001") else '0';

    -- Output result to LEDs
    LEDR(3 downto 0) <= S0; -- Output sum bits
    LEDR(4) <= S1;          -- Output carry-out

    -- 7-segment display encoding for A (HEX5)
    HEX5 <= "1000000" when A = "0000" else -- 0
            "1111001" when A = "0001" else -- 1
            "0100100" when A = "0010" else -- 2
            "0110000" when A = "0011" else -- 3
            "0011001" when A = "0100" else -- 4
            "0010010" when A = "0101" else -- 5
            "0000010" when A = "0110" else -- 6
            "1111000" when A = "0111" else -- 7
            "0000000" when A = "1000" else -- 8
            "0010000" when A = "1001" else -- 9
            "1111111"; -- Invalid input → blank

    -- 7-segment display encoding for B (HEX3)
    HEX3 <= "1000000" when B = "0000" else
            "1111001" when B = "0001" else
            "0100100" when B = "0010" else
            "0110000" when B = "0011" else
            "0011001" when B = "0100" else
            "0010010" when B = "0101" else
            "0000010" when B = "0110" else
            "1111000" when B = "0111" else
            "0000000" when B = "1000" else
            "0010000" when B = "1001" else
            "1111111";

    -- Display S1 (carry-out) on HEX1
    HEX1 <= "1000000" when S1 = '0' else
            "1111001" when S1 = '1' else
            "1111111";

    -- Display S0 (sum) on HEX0
    HEX0 <= "1000000" when S0 = "0000" else
            "1111001" when S0 = "0001" else
            "0100100" when S0 = "0010" else
            "0110000" when S0 = "0011" else
            "0011001" when S0 = "0100" else
            "0010010" when S0 = "0101" else
            "0000010" when S0 = "0110" else
            "1111000" when S0 = "0111" else
            "0000000" when S0 = "1000" else
            "0010000" when S0 = "1001" else
            "1111111"; -- Blank for invalid results

end Behavioral;
