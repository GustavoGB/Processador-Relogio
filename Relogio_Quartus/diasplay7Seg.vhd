library ieee;
use ieee.std_logic_1164.all;

entity display7Seg is
    port
    (
        clk         : IN STD_LOGIC;
        dadoHex     : IN  STD_LOGIC_VECTOR(3 downto 0);
        habilita    : IN  STD_LOGIC;
        saida7seg   : OUT STD_LOGIC_VECTOR(6 downto 0)
    );
end entity;