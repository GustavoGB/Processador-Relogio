
library IEEE;
use ieee.std_logic_1164.all;

entity conversorHex7SegDisplay is
    port
    (
        -- Input ports
		  clk: in std_logic;
        dadoHex : in  std_logic_vector(3 downto 0);
		  habilita: in std_logic;
        -- Output ports
        saida7seg : out std_logic_vector(6 downto 0)  -- := (others => '1')
    );
end entity;

architecture comportamento of conversorHex7SegDisplay is
   --
   --       0
   --      ---
   --     |   |
   --    5|   |1
   --     | 6 |
   --      ---
   --     |   |
   --    4|   |2
   --     |   |
   --      ---
   --       3
   --

  signal rascSaida7seg: std_logic_vector(6 downto 0);

begin
		
			 rascSaida7seg <=    "1000000" when dadoHex="0000" and habilita = '1' else ---0
											 "1111001" when dadoHex="0001" and habilita = '1' else ---1
											 "0100100" when dadoHex="0010" and habilita = '1' else ---2
											 "0110000" when dadoHex="0011" and habilita = '1' else ---3
											 "0011001" when dadoHex="0100" and habilita = '1' else ---4
											 "0010010" when dadoHex="0101" and habilita = '1' else ---5
											 "0000010" when dadoHex="0110" and habilita = '1' else ---6
											 "1111000" when dadoHex="0111" and habilita = '1' else ---7
											 "0000000" when dadoHex="1000" and habilita = '1' else ---8
											 "0010000" when dadoHex="1001" and habilita = '1' else ---9
											 "0001000" when dadoHex="1010" and habilita = '1' else ---A
											 "0001100" when dadoHex="1011" and habilita = '1' else ---P
											 "1000110" when dadoHex="1100" and habilita = '1' else ---C
											 "0100001" when dadoHex="1101" and habilita = '1' else ---D
											 "0000110" when dadoHex="1110" and habilita = '1' else ---E
											 "1111111" when dadoHex="1111" and habilita = '1' else ---F
											 "1111111"; -- Apaga todos segmentos.
											 
											 
	process(clk)
		begin
		if(rising_edge(clk)) then
			if(habilita = '1') then
				saida7seg <=	rascSaida7seg;
			end if;
		end if;
	end process;			
							 
	
end architecture;