library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vending_machine is
    Port (
        clk           : in STD_LOGIC;
        reset         : in STD_LOGIC;
        selection     : in STD_LOGIC_VECTOR(3 downto 0); -- wybór produktu
        dispense      : out STD_LOGIC;  -- sygna³ do wydania napoju
        display_rq    : out STD_LOGIC_VECTOR(3 downto 0); -- wyœwietlacz  --------------------------------------------------------------- /ENTITY W OSOBNYM PLIKU KTÓRA ZAJMIE SIE DISPLAYEM,
        leds          : out STD_LOGIC_VECTOR(7 downto 0); -- diody																--------- \
		-- M_BASE
		M_p_avaiab	 		: inout STD_LOGIC	:='0';
		M_pfand 			: inout UNSIGNED(7 downto 0):="00000000";
		M_p_price 			: inout UNSIGNED(7 downto 0):="00000000";
		M_aut				: inout STD_LOGIC_VECTOR(1 downto 0)		:="00";
		M_pfand_R			: inout STD_LOGIC;
		M_bottle_inserted 	: inout STD_LOGIC;
		M_p_code		  	: inout STD_LOGIC_VECTOR(3 downto 0) :="0000"
    );
end vending_machine;

architecture Behavioral of vending_machine is
    type state_type is (idle, selection_made, dispensing, error);
    signal state, next_state : state_type;
    signal product_selected : STD_LOGIC_VECTOR(3 downto 0); -- kod napoju
    signal error_code : STD_LOGIC_VECTOR(3 downto 0); -- kod b³êdu
    -- Definiowanie kodów napojów
    constant WATER_NONGAS : STD_LOGIC_VECTOR(3 downto 0) := "0001";  -- Woda niegazowana
    constant WATER_LIGHT : STD_LOGIC_VECTOR(3 downto 0) := "0010";   -- Woda lekko gazowana
    constant WATER_GAS : STD_LOGIC_VECTOR(3 downto 0) := "0011";     -- Woda gazowana
    constant JUICE_APPLE : STD_LOGIC_VECTOR(3 downto 0) := "0100";   -- Sok jab³kowy
    constant JUICE_ORANGE : STD_LOGIC_VECTOR(3 downto 0) := "0101";  -- Sok pomarañczowy
    constant JUICE_BLACKCURRANT : STD_LOGIC_VECTOR(3 downto 0) := "0110";  -- Sok porzeczkowy
    constant JUICE_GRAPEFRUIT : STD_LOGIC_VECTOR(3 downto 0) := "0111"; -- Sok grejpfrutowy
    constant PEPSI : STD_LOGIC_VECTOR(3 downto 0) := "1000";         -- Pepsi
    constant COCA_COLA : STD_LOGIC_VECTOR(3 downto 0) := "1001";     -- Coca-Cola
    
    -- Definiowanie kodów b³êdów
    constant ERROR_NO_SELECTION : STD_LOGIC_VECTOR(3 downto 0) := "1110"; -- Brak wybranego produktu	 ---------------------------------- DOROBIC KODY BLEDOW
    constant ERROR_OUT_OF_ORDER : STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- Awaria													-------	Z NASZEGO PLIKU
	
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

    process(clk, reset)
    begin
        if reset = '1' then
            state <= idle;
            dispense <= '0';
            display_rq <= (others => '0');
            leds <= (others => '0');
			-------------------------
        elsif rising_edge(clk) then
            state <= next_state;  
			-------------------------
			-- zamiast tego wyzej zrobiæ
			-- elsif rising_edge(clk) then
			-- ile cykli minelo od ostatniego zmianu stanu +=1
			-- elseif rising_edge(clk) AND ilosc_cykli>100
			-- state <= next_state;					 -- to ma dzialac jako zabezpieczenie, zeby program  nie zmienial cykli zbyt czesto
        end if;
    end process;
	
	
    process(state, selection, M_aut)
    begin
        case state is
            when idle =>
                dispense <= '0';
                leds <= "00000000"; 
                display_rq <= "0000"; 								   -- 
                if selection /= "0000" then-- jesli wybrano produkt	   -- sprawdziæ i poczekaæ na informacje, ¿e produkt jest w systemie
                    product_selected <= selection; 					   -- poprostu dla ka¿dego produktu wypisuje, czy jego iloœæ jest wiêksza ni¿ 1
                    -- jesli produkt jest na stanie, to
					-- "WYBRANO PRODUKT XYZ"
					-- "sprawdzam cene;
					next_state <= selection_made; -- i jeszcze to
					-----------
					-- jesli produktu nie ma na stanie, to
					-- "BRAK PRODUKTU XYZ"
                else
                    next_state <= idle; 
                end if;

            when selection_made =>
                display_rq <= product_selected; 										-- "wybrano napoj X"
                if M_aut = "10" then											    -- if card_payment = '10' then
                    next_state <= dispensing;											-- if card_payment = '01' then wyrzuæ kod jaki mieliœmy 
                else												   					-- else wait for paiment
                    next_state <= selection_made; 
                end if;

            when dispensing =>
                dispense <= '1'; 
                leds <= "11111111"; 
                display_rq <= product_selected; -- "NALEWAM NAPOJ X"
                next_state <= idle; 

            when others =>
                next_state <= idle;
        end case;
    end process;
end Behavioral;