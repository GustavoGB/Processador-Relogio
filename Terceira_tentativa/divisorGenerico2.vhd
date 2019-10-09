LIBRARY ieee;
   USE ieee.std_logic_1164.ALL;
   use ieee.numeric_std.all;

   entity divisorGenerico2 is
    generic
    (divisor : natural:=  1000000);
       port(
           clk      :   in std_logic;
			  hab : in std_logic;
			  clear : in std_logic;
           saida_clk :   out std_logic
           );
   end entity;	
	
 architecture divInteiro of divisorGenerico2 is
        signal tick : std_logic := '0';
        signal contador : integer range 0 to divisor+1 := 0;
   begin
        process(clk)
        begin
            if rising_edge(clk) then
					if hab = '1' then
						if contador = divisor then
							  contador <= 0;
							  tick <= not tick;
						 else
							  contador <= contador + 1;
						 end if;
					else
						contador <= 0;
					end if;
            end if;
        end process;
    saida_clk <= tick;
    end architecture divInteiro;
