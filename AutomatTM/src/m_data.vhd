-------------------------------------------------------------------------------
--
-- Title       : M_Data
-- Design      : AutomatTM
-- Author      : jakub.bullmann@student.pk.edu.pl
-- Company     : Politechnika Krakowska
--
-------------------------------------------------------------------------------
--
-- File        : C:/Users/jbull/OneDrive/Dokumenty/projektyVHDL/Automat_z_napojami/Automat-z-napojami/AutomatTM/src/M_Data.vhd
-- Generated   : Sun Dec  1 21:49:27 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
----------------------------------------------------------------------------
-- Description : 
--
---------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity M_Data is
	port(
		DB_p_code : in STD_LOGIC_VECTOR (3 downto 0);  -- od 1 do 9
		DB_p_price : out UNSIGNED(7 downto 0);
		DB_p_avaiab : out STD_LOGIC;
		-- -mag_vect
		mag_n1 : in STD_LOGIC_VECTOR(1 downto 0) :="00";
		mag_n2 : in STD_LOGIC_VECTOR(1 downto 0) :="00";
		mag_n3 : in STD_LOGIC_VECTOR(1 downto 0) :="00";
		mag_n4 : in STD_LOGIC_VECTOR(1 downto 0) :="00";
		mag_n5 : in STD_LOGIC_VECTOR(1 downto 0) :="00";
		mag_n6 : in STD_LOGIC_VECTOR(1 downto 0) :="00";
		mag_n7 : in STD_LOGIC_VECTOR(1 downto 0) :="00";
		mag_n8 : in STD_LOGIC_VECTOR(1 downto 0) :="00";
		mag_n9 : in STD_LOGIC_VECTOR(1 downto 0) :="00"
		
	);
end M_Data;

--}} End of automatically maintained section

architecture M_Data of M_Data is

	signal 		price: 		UNSIGNED(7 downto 0) 	:= (others => '0');
	signal 		avaiable: 	STD_LOGIC 	:='0';
	constant 	cost_h2n: 	UNSIGNED(7 downto 0) :="00100100";-- cena *10 gr =	200
    constant 	cost_h2l: 	UNSIGNED(7 downto 0) :="00100100";-- cena *10 gr =	200
    constant 	cost_h2g: 	UNSIGNED(7 downto 0) :="00100100";-- cena *10 gr =	200
    constant 	cost_app: 	UNSIGNED(7 downto 0) :="00101000";-- cena *10 gr = 400
    constant 	cost_ong: 	UNSIGNED(7 downto 0) :="00101000";-- cena *10 gr = 400
    constant 	cost_curr:	UNSIGNED(7 downto 0) :="00101000";-- cena *10 gr = 400
    constant 	cost_gfrt:	UNSIGNED(7 downto 0) :="00101000";-- cena *10 gr = 400
    constant 	cost_pxi:	UNSIGNED(7 downto 0) :="00111000";-- cena *10 gr = 500
    constant 	cost_cola:	UNSIGNED(7 downto 0) :="00111000";-- cena *10 gr = 500

begin
	process(DB_p_code)
		begin
		case DB_p_code is
			when "0001" =>
				price <= cost_h2n;
				avaiable <=	mag_n1(0) OR mag_n1(1);
			when "0010" =>
				price <= cost_h2l;
				avaiable <=	mag_n2(0) OR mag_n2(1);
			when "0011" =>
				price <= cost_h2g;
				avaiable <=	mag_n3(0) OR mag_n3(1);
			when "0100" =>
				price <= cost_app;
				avaiable <=	mag_n4(0) OR mag_n4(1);
			when "0101" =>
				price <= cost_ong;	   
				avaiable <=	mag_n5(0) OR mag_n5(1);
			when "0110" =>
				price <= cost_curr;
				avaiable <=	mag_n6(0) OR mag_n6(1);
			when "0111" =>
				price <= cost_gfrt;
				avaiable <=	mag_n7(0) OR mag_n7(1);
			when "1000" =>
				price <= cost_pxi;
				avaiable <=	mag_n8(0) OR mag_n8(1);
			when "1001" =>
				price <= cost_cola;
				avaiable <=	mag_n9(0) OR mag_n9(1);
			when others =>
				price<="00000000";
				avaiable<='0';
		end case;
		DB_p_price <= price;
		DB_p_avaiab <= avaiable;
	end process;
		
end M_Data;
