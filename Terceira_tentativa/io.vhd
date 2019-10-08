library ieee;
use ieee.std_logic_1164.all;

entity io is
    port
    (
        entradaChaves   : IN STD_LOGIC_VECTOR(1 downto 0);
		  entradaBaseTempo : IN STD_LOGIC;
		  habilitaBaseTempo: IN STD_LOGIC;
        habilitaChaves        : IN  STD_LOGIC;
        saida           : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture Arc of io is
begin
	process(entradaChaves, entradaBaseTempo, habilitaChaves, habilitaBaseTempo)
	begin
		if habilitaChaves = '1' then
			if habilitaBaseTempo = '1' then
				saida <= "01" & entradaChaves;
			else
				saida <= "0000";
			end if;
		else
			if habilitaBaseTempo = '1' then
				saida <= "0100";
			else
				saida <= "0000";
			end if;
		end if;		
	end process;
end architecture;