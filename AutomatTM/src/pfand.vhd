library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pfand is
    Port (
        reset            : in std_logic;                    -- Reset signal
        bottle_inserted  : in std_logic;                  -- Signal indicating a bottle has been inserted
        pfand_value      : out std_logic_vector (7 downto 0) -- Total pfand value in cents as a 4-bit std_logic_vector
    );
end pfand;

architecture Behavioral of pfand is
    constant SINGLE_BOTTLE_PFAND : integer := 1; -- Fixed pfand value for each bottle
	constant LIMIT_BOTTLES : integer := 4; -- Fixed limit for bottles which can be inserted
    signal bottle_counter       : integer := 0;     -- Counter for the number of bottles
    signal total_pfand         : integer;           -- Intermediate signal to hold the total pfand for all bottles
begin

    -- Counting logic
    process(reset, bottle_inserted)
    begin
        --if reset = '1' then
        --    bottle_counter <= 0; 	-- Reset counter to 0
		--end if;
		if bottle_inserted = '1' then
            if bottle_counter < LIMIT_BOTTLES then
                bottle_counter <= bottle_counter + 1; -- Increment the counter
            end if;
        end if;
    end process;

    -- Calculate total pfand based on the current bottle count
    process(bottle_counter)
    begin
	 	
		case bottle_counter is
			when 0 =>
			pfand_value <="00000000";
			when 1 =>
			pfand_value <="00000001";
			when 2 =>
			pfand_value <="00000010";
			when 3 =>
			pfand_value <="00000011";
			when 4 =>
			pfand_value <="00000100";
			when 5 => 
			pfand_value <="00000101";
			when others =>
			pfand_value <="00000110";
			end case;

    end process;

end Behavioral;