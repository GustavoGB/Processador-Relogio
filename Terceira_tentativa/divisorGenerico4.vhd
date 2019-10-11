LIBRARY ieee;
   USE ieee.std_logic_1164.ALL;
   use ieee.numeric_std.all;

   entity divisorGenerico4 is
    generic
    (divisor : natural:=  10000);
       port(
           clk      :   in std_logic;
           saida_clk :   out std_logic
           );
   end entity;	
	
 architecture divInteiro of divisorGenerico4 is
        signal tick : std_logic := '0';
        signal contador : integer range 0 to divisor+1 := 0;
   begin
        process(clk)
        begin
            if rising_edge(clk) then
				
						if contador >= divisor then
							  contador <= 0;
							  tick <= '1';
						 else
							  contador <= contador + 1;
							  tick <= '0';
						 end if;
					
            end if;
        end process;
    saida_clk <= tick;
    end architecture divInteiro;