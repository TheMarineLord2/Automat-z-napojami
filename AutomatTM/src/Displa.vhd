library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Displa is
    Port (
        clk              : in  STD_LOGIC;
        reset            : in  STD_LOGIC;
        selected           : in  STD_LOGIC_VECTOR(3 downto 0); -- Wybór napoju
        error_code            : in  STD_LOGIC_VECTOR(3 downto 0); --numer b³êdu
        displey_communication : out STD_LOGIC_VECTOR(7 downto 0)
       
    );
end Displa;

architecture Displey of Displa is

    constant no_product : STD_LOGIC_VECTOR(3 downto 0) := "0101";  --  Produktu brak"
    constant released_product : STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- Produkt wydany
    constant product_problem : STD_LOGIC_VECTOR(3 downto 0) := "0101";  --  Inny prblem
  signal product_code : STD_LOGIC_VECTOR(3 downto 0); -- Kod  produktu na wyjœciu

begin
    process(clk, reset)
    begin
        if reset = '1' then
            displey_communication <= "00000000"; -- Brak  komunikatu
        elsif rising_edge(clk) then
     product_code <= product_problem;
        end if;
    end process;

    process(selected, error_code)
    begin
   
                    if error_code = "0101" then
                        -- wariant 1 
                        product_code <= selected ;
                        product_code<=released_product; 
                       
                    elsif error_code = "0111" then
                        -- wariant 2
                        product_code <= selected ;
                        product_code<=no_product; 
                    
                    else
                        -- wariant 3
                        --inny problem 
                    product_code <= selected ;
                    product_code<=product_problem; 
                    end if;

          displey_communication<="0000" & product_code;
               

            
    end process;


end Displey;
