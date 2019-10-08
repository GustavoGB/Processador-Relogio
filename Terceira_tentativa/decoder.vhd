library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
	 port
    (
       endereco : in std_logic_vector(3 downto 0); -- Endereco de entrada
		 readEnable : in std_logic; 
		 writeEnable : in std_logic;  
		 eseg70, eseg71, eseg72, eseg73, eseg74, eseg75, eseg76, eseg77 : out std_logic; 
		 esw : out std_logic;
		 ebt : out std_logic;
		 clear : out std_logic
		 
    );
end entity;

architecture Arc of decoder is


begin

		eseg70 <= '1' when (endereco = "0000" AND writeEnable = '1') else '0';
		eseg71 <= '1' when (endereco = "0001" AND writeEnable = '1') else '0';
		eseg72 <= '1' when (endereco = "0010" AND writeEnable = '1') else '0';
		eseg73 <= '1' when (endereco = "0011" AND writeEnable = '1') else '0';
		eseg74 <= '1' when (endereco = "0100" AND writeEnable = '1') else '0';
		eseg75 <= '1' when (endereco = "0101" AND writeEnable = '1') else '0';
		eseg76 <= '1' when (endereco = "1111" AND writeEnable = '1') else '0'; --Não estamos usando
		eseg77 <= '1' when (endereco = "1111" AND writeEnable = '1') else '0'; --Não estamos usando
		esw    <= '1' when ((endereco = "1000" AND readEnable = '1') or (endereco = "1001" AND readEnable = '1')) else '0';
		ebt <= '1'    when (endereco = "0110" AND readEnable = '1') else '0';
		clear <= '1' when (endereco = "0111" AND readEnable = '1') else '0';
			
end architecture;