library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Utilizado para o Generic

entity pc is
    generic (largura_PC_endereco : natural := 8);
    
	 port
    (
	   clk: in std_logic;
      A: in std_logic_vector(largura_PC_endereco-1 downto 0);		
      instrucao: out std_logic_vector(largura_PC_endereco-1 downto 0)
    );
end entity;

architecture Arch of pc is

begin

	process(clk)
	  begin
		 if (rising_edge(clk)) then
			  
			  instrucao <= A;
			
		 end if;
	  end process;


end architecture;