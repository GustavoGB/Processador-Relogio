library IEEE;
use ieee.std_logic_1164.all;

entity muxULA is

	Generic ( largura_dados : natural := 4 );
	
	-- O mux recebe as entradas A, B e o seletor.
	-- A resposta é dada por X.
	
   port
    (
         A : in std_logic_vector(largura_dados-1 downto 0);
		 B : in std_logic_vector(largura_dados-1 downto 0);
		 
		 sel : in std_logic;
		 
		 X : out std_logic_vector(largura_dados-1 downto 0)
    );
end entity;

architecture Arc of muxULA is
-- Se o seletor for 0, escolhe-se A
-- Se o seletor for 1, escolhe-se B

begin
    
	process(A,B,sel)
	begin
		case sel is
			when '0' =>
				X <= A;
			when '1' =>
				X <= B;
		end case;
	end process;
	 
end architecture;