library ieee;
use ieee.std_logic_1164.all;

entity io is
    port
    (
        entradaChaves   : IN STD_LOGIC_VECTOR(1 downto 0);
		  entradaBaseTempo : IN STD_LOGIC;
		  habilitaBaseTempo: IN STD_LOGIC;
		  --habilitaChaves: IN STD_LOGIC;
        --Vel        : IN  STD_LOGIC;
        saida           : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture Arc of io is
begin
	saida <= "0100" when (entradaBaseTempo = '1' and habilitaBaseTempo = '1') else "0000";
end architecture;