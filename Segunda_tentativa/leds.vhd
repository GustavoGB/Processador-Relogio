library ieee;
use ieee.std_logic_1164.all;

entity leds is
    generic (
        quantidadeLeds      : natural := 2
    );
    port
    (
        clk         : IN  STD_LOGIC;
        dados       : IN  STD_LOGIC_VECTOR(quantidadeLeds-1 downto 0);
        habilita    : IN  STD_LOGIC;
        saidaLeds   : OUT STD_LOGIC_VECTOR(quantidadeLeds-1 downto 0)
    );
end entity;