library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity: C4M1P4
-- Description: Adds two 4-bit numbers with carry-in, displays inputs and result on 7-segment displays.
entity C4M1P4 is
    Port (
        x       : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input x (first operand)
        y       : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input y (second operand)
        cin     : in  STD_LOGIC;                    -- Carry-in input
        s       : out STD_LOGIC_VECTOR(3 downto 0); -- Output 4-bit sum
        cout    : out STD_LOGIC;                    -- Output carry-out
        HEX1    : out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment display: tens digit of result
        HEX0    : out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment display: ones digit of result
        HEX3    : out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment display: input x
        HEX5    : out STD_LOGIC_VECTOR(6 downto 0)  -- 7-segment display: input y
    );
end C4M1P4;

architecture Behavioral of C4M1P4 is

    signal A : STD_LOGIC_VECTOR(3 downto 0);     -- Adjusted binary result (used if sum > 9)
    signal z1 : STD_LOGIC;                       -- High when V > 9 (for BCD correction)
    signal z2 : STD_LOGIC;                       -- High when V > 8 (for edge case when carry is present)
    signal V  : STD_LOGIC_VECTOR(3 downto 0);    -- Sum result from 4-bit adder
    signal d0 : STD_LOGIC_VECTOR(3 downto 0);    -- Final value to be shown on HEX0
    signal cout_internal : STD_LOGIC;            -- Internal carry-out signal

    -- Declare the 4-bit adder component to be instantiated
    component four_bit_adder
        Port (
            a       : in  STD_LOGIC_VECTOR(3 downto 0);
            b       : in  STD_LOGIC_VECTOR(3 downto 0);
            cin     : in  STD_LOGIC;
            s       : out STD_LOGIC_VECTOR(3 downto 0);
            cout    : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the 4-bit adder to add x + y + cin
    U1 : four_bit_adder port map (x, y, cin, V, cout_internal);

    -- Output result signals
    s <= V;
    cout <= cout_internal;

    -- Check if V > 9 (needed for BCD correction)
    z1 <= '1' when V > "1001" else '0';

    -- Check if V > 8 (used when carry-out is also set)
    z2 <= '1' when V > "1000" else '0';

    -- Circuit A: adjust result for BCD if V > 9
    A(3) <= '0';                     -- A3 is always 0
    A(2) <= V(1) and V(2);           -- A2 logic
    A(1) <= not V(1);                -- A1 logic
    A(0) <= V(0);                    -- A0 directly from V

    -- Display input x on HEX3 using standard 7-segment encoding
    HEX3 <= 
        "1000000" when x = "0000" else -- 0
        "1111001" when x = "0001" else -- 1
        "0100100" when x = "0010" else -- 2
        "0110000" when x = "0011" else -- 3
        "0011001" when x = "0100" else -- 4
        "0010010" when x = "0101" else -- 5
        "0000010" when x = "0110" else -- 6
        "1111000" when x = "0111" else -- 7
        "0000000" when x = "1000" else -- 8
        "0011000" when x = "1001" else -- 9
        "1111111";                     -- Blank for undefined inputs

    -- Display input y on HEX5 using standard 7-segment encoding
    HEX5 <= 
        "1000000" when y = "0000" else -- 0
        "1111001" when y = "0001" else -- 1
        "0100100" when y = "0010" else -- 2
        "0110000" when y = "0011" else -- 3
        "0011001" when y = "0100" else -- 4
        "0010010" when y = "0101" else -- 5
        "0000010" when y = "0110" else -- 6
        "1111000" when y = "0111" else -- 7
        "0000000" when y = "1000" else -- 8
        "0011000" when y = "1001" else -- 9
        "1111111";                     -- Blank for undefined inputs

    -- Output display logic for the result (HEX1 = tens digit, HEX0 = ones digit)
    process(cout_internal, V)
    begin
        if cout_internal = '0' then
            -- No carry-out
            if z1 = '0' then
                HEX1 <= "1000000"; -- Display 0 on HEX1
                d0 <= V;
            else
                HEX1 <= "1111001"; -- Display 1 on HEX1 (means 10-15)
                d0 <= A;           -- Adjusted value for HEX0
            end if;

            -- Display the ones digit on HEX0
            case d0 is
                when "0000" => HEX0 <= "1000000"; -- 0
                when "0001" => HEX0 <= "1111001"; -- 1
                when "0010" => HEX0 <= "0100100"; -- 2
                when "0011" => HEX0 <= "0110000"; -- 3
                when "0100" => HEX0 <= "0011001"; -- 4
                when "0101" => HEX0 <= "0010010"; -- 5
                when "0110" => HEX0 <= "0000010"; -- 6
                when "0111" => HEX0 <= "1111000"; -- 7
                when "1000" => HEX0 <= "0000000"; -- 8
                when "1001" => HEX0 <= "0011000"; -- 9
                when others => HEX0 <= "1111111"; -- Blank
            end case;

        else
            -- Carry-out is 1
            if V = "1001" then
                HEX1 <= "1111001"; -- Display 1 on HEX1
                HEX0 <= "1000000"; -- Display 0 on HEX0
            else
                if z2 = '0' then
                    HEX1 <= "1000000"; -- Display 0 on HEX1
                    d0 <= V;
                else
                    HEX1 <= "1111001"; -- Display 1 on HEX1
                    d0 <= A;
                end if;

                -- Display adjusted ones digit
                case d0 is
                    when "0000" => HEX0 <= "1111001"; -- 0
                    when "0001" => HEX0 <= "0100100"; -- 1
                    when "0010" => HEX0 <= "0110000"; -- 2
                    when "0011" => HEX0 <= "0011001"; -- 3
                    when "0100" => HEX0 <= "0010010"; -- 4
                    when "0101" => HEX0 <= "0000010"; -- 5
                    when "0110" => HEX0 <= "1111000"; -- 6
                    when "0111" => HEX0 <= "0000000"; -- 7
                    when "1000" => HEX0 <= "0011000"; -- 8
                    when others => HEX0 <= "1111111"; -- Blank
                end case;
            end if;
        end if;
    end process;

end Behavioral;
