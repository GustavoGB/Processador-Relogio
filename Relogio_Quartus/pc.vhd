library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Utilizado para o Generic

entity pc is
    generic (largura_PC_dados : natural := 10);
    
	 port
    (
	  clk: in std_logic;
      imediato: in std_logic_vector(largura_PC_dados-1 downto 0);
      uc_habilita: in std_logic;
		
      instrucao: out std_logic_vector(largura_PC_dados-1 downto 0)
    );
end entity;

architecture Arc of pc is

  signal sig_out_mux, sig_somador : std_logic_vector(largura_PC_dados-1 downto 0);
  signal sig_in_soma : std_logic_vector(largura_PC_dados-1 downto 0) := (others=>'0');

begin

	SOMADOR: entity work.somador
	  Generic Map(largura_dados=>largura_PC_dados)
	  Port Map(A=>sig_in_soma,clk=>clk,Y=>sig_somador);

  MUX: entity work.mux
	  Generic Map(largura_dados=> largura_PC_dados)
	  Port Map(A=>sig_somador,B=>imediato,sel=>uc_habilita,Y=>sig_out_mux);

	process(clk)
	  begin
		 if (rising_edge(clk)) then
			  
			  instrucao <= sig_out_mux;
			  sig_in_soma <= sig_out_mux;
			
		 end if;
	  end process;


end architecture;