LIBRARY ieee;
   USE ieee.std_logic_1164.ALL;
   use ieee.numeric_std.all;

   entity fliflopRESET is
    generic
    (divisor : natural:=  1000000);
       port(
				d : in std_Logic_vector  := "001";
           clk       :   in std_logic;
			  reset : in std_logic;
			  ampm : in std_logic;
           saida_clk :   out std_logic_vector(3 downto 0)
           );
   end entity;	
	
 architecture arc_fliflopRESET of fliflopRESET is
 
begin
process (clk)
begin
	-- Reset whenever the reset signal goes low, regardless of the clock
	if (reset = '1') then
		saida_clk <= ampm & "000";
	-- If not resetting, update the register output on the clock's rising edge
	elsif (rising_edge(clk)) then
		saida_clk <= ampm & d;
	end if;
end process;
 end architecture arc_fliflopRESET;
