library ieee;
use ieee.std_logic_1164.all;

entity chaves is
    generic (
        largura    : natural := 2
    );
    port
    (
        entradaChaves   : IN STD_LOGIC_VECTOR(largura-1 downto 0);
        habilita        : IN  STD_LOGIC;
        saida           : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture Arc of chaves is
begin
		saida <= ('0' & '0' & entradaChaves);			
end architecture;