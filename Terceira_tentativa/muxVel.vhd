library IEEE;
use ieee.std_logic_1164.all;

entity muxVel is	
	-- O mux recebe as entradas A, B e o seletor.
	-- A resposta é dada por X.
	
   port
    (
         A : in std_logic;
		 B : in std_logic;
		 
		 sel : in std_logic;
		 
		 X : out std_logic_vector(3 downto 0)
    );
end entity;

architecture Arc of muxVel is
-- Se o seletor for 0, escolhe-se A
-- Se o seletor for 1, escolhe-se B

begin
  
	
	X <= "000" & A when sel = '0' else
		  "000" & B when sel = '1';
	 
end architecture;