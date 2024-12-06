library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pfand is
    Port (
        reset            : in std_logic;                    -- Reset signal
        bottle_inserted  : in std_logic;                   -- Signal indicating a bottle has been inserted
        pfand_value      : out unsigned (7 downto 0) -- Total pfand value in cents as a 4-bit std_logic_vector
    );
end pfand;

architecture Behavioral of pfand is
    constant SINGLE_BOTTLE_PFAND : integer := 2; -- Fixed pfand value for each bottle
	 constant LIMIT_BOTTLES : integer := 5; -- Fixed limit for bottles which can be inserted
    signal bottle_counter       : integer := 0;     -- Counter for the number of bottles
    signal total_pfand         : integer;           -- Intermediate signal to hold the total pfand for all bottles
begin

    -- Counting logic
    process(reset, bottle_inserted)
    begin
        if reset = '1' then
            bottle_counter <= 0; 	-- Reset counter to 0
        elsif bottle_inserted = '1' then
            if bottle_counter < LIMIT_BOTTLES then
                bottle_counter <= bottle_counter + 1; -- Increment the counter
            end if;
        end if;
    end process;

    -- Calculate total pfand based on the current bottle count
    process(bottle_counter)
    begin
	 
        total_pfand <= SINGLE_BOTTLE_PFAND * bottle_counter;

        -- Output the total pfand as std_logic_vector
        pfand_value <= to_unsigned(total_pfand, 8);

    end process;

end Behavioral;