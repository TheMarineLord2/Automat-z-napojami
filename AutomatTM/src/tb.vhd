library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
	-- no ports for tb
end tb;


architecture tb of tb is
		signal clk_tb         	: STD_LOGIC:='0';
        signal reset_tb         : STD_LOGIC:='0';
        signal selection_tb     : STD_LOGIC_VECTOR(3 downto 0); -- wybór produktu
        signal dispense_tb      : STD_LOGIC:='0';  -- sygna³ do wydania napoju
        signal display_rq_tb    : STD_LOGIC_VECTOR(3 downto 0); -- wyœwietlacz
		signal leds_tb          : STD_LOGIC_VECTOR(7 downto 0); -- diody																--------- \
		-- M_BASE
		signal M_p_avaiab_tb	:  STD_LOGIC	:='0';
		signal M_pfand_tb 		:  STD_LOGIC_VECTOR(7 downto 0):="00000000";
		signal M_p_price_tb 	:  UNSIGNED(7 downto 0):="00000000";
		signal M_p_price2p_tb	:  UNSIGNED(7 downto 0):="00000000";
		signal M_aut_tb			:  STD_LOGIC_VECTOR(1 downto 0)		:="00";
		signal M_pfand_R_tb		:  STD_LOGIC:='0';
		signal M_bottle_inserted_tb :  STD_LOGIC:='0';

begin
	
	
	mob: entity work.vending_machine_real PORT MAP (
		clk => clk_tb,     
        reset => reset_tb,     
        selection => selection_tb,   
        dispense => dispense_tb, 
        display_rq => display_rq_tb,  
		leds => leds_tb,     									
		-- M_BASE
		M_p_avaiab => M_p_avaiab_tb,	 	
		M_pfand => M_pfand_tb, 		
		M_p_price => M_p_price_tb, 		
		M_p_price2p => M_p_price2p_tb,
		M_aut =>M_aut_tb,				
		M_pfand_R => M_pfand_R_tb,			
		M_bottle_inserted => M_bottle_inserted_tb 
		);
	
		
	process
		begin
		clk_tb<=not clk_tb;
		wait for 5ns;
		end process;
		
		
		
		simulator_tb : process
		begin 
		M_aut_tb <= "00";	
		reset_tb <= '1';
        wait for 5ns;
        reset_tb <= '0';
        selection_tb <= "0000";  -- Selecting Water light
        wait for 5ns;   -- Wait for clock edge
        M_aut_tb <= "00";         -- No payment0
        wait for 5ns;   -- Wait for clock edge
        M_bottle_inserted_tb <= '1';         -- No payment0	 
		wait for 5ns; 
		M_bottle_inserted_tb <= '0';
		wait for 5ns;   -- Wait for clock edge
        M_bottle_inserted_tb <= '1';         -- No payment0	 
		wait for 5ns; 
		M_bottle_inserted_tb <= '0';         -- No payment0	 
		wait for 5ns; 
		selection_tb <= "0010";  -- Selecting Water light
        wait for 15ns;
		M_aut_tb <= "10";
				  
        wait;  -- Wait and observe behavior
		end process;
end tb;
