LIBRARY ieee;
   USE ieee.std_logic_1164.ALL;
   use ieee.numeric_std.all;

   entity divisorGenerico is
    generic
    (divisor1 : natural := 50000000;
		divisor2 : natural:=  7000000;
		divisor3 : natural := 1000000);
       port(
           clk      :   in std_logic;
           saida_clk :   out std_logic
           );
   end entity;	
	
 architecture divInteiro of divisorGenerico is
        signal tick : std_logic := '0';
        signal contador : integer range 0 to divisor1+1 := 0;
   begin
        process(clk)
        begin
            if rising_edge(clk) then
					if esw = '1' and esw2 = '1' then
						if contador = divisor3 then
							  contador <= 0;
							  tick <= not tick;
						 else
							  contador <= contador + 1;
						 end if;
					end if;
					if esw2 = '1' then
						if contador = divisor2 then
							  contador <= 0;
							  tick <= not tick;
						 else
							  contador <= contador + 1;
						 end if;
					end if;
					if esw1 = '0' AND esw2 = '0' then
						if contador = divisor1 then
							contador <= 0;
							tick <= not tick;
						end if;
					end if;
            end if;
        end process;
    saida_clk <= tick;
    end architecture divInteiro;
