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

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; 

entity M_Base is
	port(

	);
end M_Base;

architecture M_Base of M_Base is
begin
   
	
	uut1: entity work.pfand PORT MAP (
	    pfand_value => M_pfand,
		reset => M_pfand_R,
		bottle_inserted => M_bottle_inserted
		
	);
	uut2: entity work.payment PORT MAP (
	    price_to_pay => M_p_price,
	    payment_status  => M_aut,
 		pfand_reset => M_pfand_R
	);
	uut3: entity work.m_data PORT MAP (
		DB_p_code => M_p_code,
		DB_p_price => M_p_price,
		DB_p_avaiab => M_p_avaiab
  );

end M_Base;
