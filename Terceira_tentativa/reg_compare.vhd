library IEEE;
use ieee.std_logic_1164.all;

entity reg_compare is
    port
    (
       A : in std_logic_Vector(2 downto 0);
		 Clock, habilita: in std_logic;
		 B			 : out std_logic_vector(2 downto 0)
    );
end entity;


architecture Arc of reg_compare is
begin
	
	process(A, Clock)
	begin
	
		if (rising_edge(Clock) and habilita = '1') then 
			B <= A;
		end if;
	end process;
end architecture;