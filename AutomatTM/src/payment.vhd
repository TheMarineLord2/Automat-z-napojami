library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity payment is
    Port (
        price_to_pay   : in  UNSIGNED (7 downto 0);
        payment_status : out STD_LOGIC_VECTOR(1 downto 0);                     -- Output signal: '1' = approved, '0' = rejected
        pfand_reset    : out STD_LOGIC                     -- Reset signal: '1' = reset, '0' = not reset
    );
end payment;

architecture Behavioral of payment is
    -- Maximum value for credit
    constant MAX_APPROVED_CREDIT : integer := 50;

    signal price_integer : integer;
begin

    -- Convert STD_LOGIC_VECTOR to integer
    process(price_to_pay)
    begin
        price_integer <= to_integer(price_to_pay);
        
        -- Comparison to determine payment status
        if price_integer <= MAX_APPROVED_CREDIT then
            payment_status <= "10";  -- Approved
            pfand_reset <= '1';      -- Reset
        else
            payment_status <= "01";  -- Rejected
            pfand_reset <= '0';      -- Not reset
        end if;
    end process;

end Behavioral;