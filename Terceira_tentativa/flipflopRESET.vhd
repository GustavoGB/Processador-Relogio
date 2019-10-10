LIBRARY ieee;
   USE ieee.std_logic_1164.ALL;
   use ieee.numeric_std.all;

   entity fliflopRESET is
    generic
    (divisor : natural:=  1000000);
       port(
				d : in std_Logic_vector  := "0001";
           clk       :   in std_logic;
			  reset : in std_logic;
           saida_clk :   out std_logic_vector(3 downto 0)
           );
   end entity;	
	
 architecture arc_fliflopRESET of fliflopRESET is
 
begin
process (clk)
begin
	-- Reset whenever the reset signal goes low, regardless of the clock
	if (reset = '1') then
		saida_clk <= "0000";
	-- If not resetting, update the register output on the clock's rising edge
	elsif (rising_edge(clk)) then
		saida_clk <= d;
	end if;
end process;
 end architecture arc_fliflopRESET;
	
-- architecture divInteiro of divisorGenerico2 is
--        signal tick : std_logic := '0';
--        signal contador : integer range 0 to divisor+1 := 0;
--   begin
--        process(clk)
--        begin
--            if rising_edge(clk) then
--					if hab = '1' then
--						if contador >= divisor then
--							  contador <= 0;
--							  tick <= '1';
--						 else
--								tick <= '0';
--							  contador <= contador + 1;
--						 end if;
--					else
--						contador <= 0;
--					end if;
--            end if;
--        end process;
--    saida_clk <= tick;
--    end architecture divInteiro;
