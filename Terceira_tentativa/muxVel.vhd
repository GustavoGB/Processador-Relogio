library IEEE;
use ieee.std_logic_1164.all;

entity muxVel is	
	-- O mux recebe as entradas A, B e o seletor.
	-- A resposta é dada por X.
	
   port
    (
       A : in std_logic;
		 B : in std_logic;
       C : in std_logic;
		 D : in std_logic;		 
		 sel : in std_logic_Vector(1 downto 0);
		 
		 X : out std_logic
    );
end entity;

architecture Arc of muxVel is
-- Se o seletor for 0, escolhe-se A
-- Se o seletor for 1, escolhe-se B

begin
  
	
	X <= A when sel = "00" else
		   B when sel = "01" else
			C when sel = "10" else
			D when sel = "11";
	 
end architecture;