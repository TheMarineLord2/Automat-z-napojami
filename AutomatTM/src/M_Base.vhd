-------------------------------------------------------------------------------
--
-- Title       : M_Base
-- Design      : AutomatTM
-- Author      : jakub.bullmann@student.pk.edu.pl
-- Company     : Politechnika Krakowska
--
-------------------------------------------------------------------------------
--
-- Description : This module recives product_code, checks avaiability and price,
--				compares this value with pfand and requests payment to be made.
--				-- When payment is made, it resets necessary values and prowides
--				motherboard with data.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--    and may be overwritten
--{entity {M_Base} architecture {M_Base}}

library IEEE;
use IEEE.std_logic_1164.all;

entity M_Base is
	port(
		Mpavaiab	 	: in STD_LOGIC							:='0';
		M_pfand 		: in STD_LOGIC_VECTOR(3 downto 0)		:="0000";
		M_p_price_in 	: in STD_LOGIC_VECTOR(5 downto 0)		:="000000";
		M_pay_aut_in	: in STD_LOGIC_VECTOR(1 downto 0)		:="00";
		M_pay_aut_out	: out STD_LOGIC_VECTOR(1 downto 0)		;
		M_p_price_out 	: out STD_LOGIC_VECTOR(5 downto 0)		;
		M_pfand_R		: out STD_LOGIC	
	);
end M_Base;

--}} End of automatically maintained section  

--uut1: entity work.database PORT MAP (
	--   DB_p_code => M_p_code,
	--  DB_p_price => M_p_price,
	-- DB_p_avaiab => M_p_avaiab
--  );
--uut2: entity work.pfand PORT MAP (
	--    PF_pfand => M_pfand,
	--    PF_reset => M_pfand_R
--	);
--uut3: entity work.credit_card PORT MAP (
	--    CC_price => M_p_price_out,
	--    CC_auth  => M_auth_in
--	);

architecture M_Base of M_Base is
begin

	-- Enter your statements here --

end M_Base;
