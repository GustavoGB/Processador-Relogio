-- A library clause declares a name as a library.  It 
-- does not create the library; it simply forward declares 
-- it. 
library ieee;

-- Use clauses import declarations into the current scope.	
-- If more than one use clause imports the same name into the
-- the same scope, none of the names are imported.

-- Import all the declarations in a package
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;




entity ula is
	Generic ( largura_Dados : natural := 5 );
	
	port
	(
		A : in std_logic_vector (largura_Dados-1 downto 0);
		B : in std_logic_vector (largura_Dados-1 downto 0);
		func : in std_logic_vector (2 downto 0);
		C : out std_logic_vector (largura_Dados-1 downto 0);
		-- Flag
		equal : out std_logic;
	);
end ula;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture Arch of ula is
	signal igual : std_logic;
	
	constant Add : std_logic_vector(2 downto 0) := "000";
	constant Sub : std_logic_vector(2 downto 0) := "001";

	-- Transfere a entrada superior(A) para a saida da ULA(C)
    constant RetA : std_logic_vector(2 downto 0) := "010";
     -- Transfere a entrada inferior(B) para a saida da ULA(C)
	constant RetB : std_logic_vector(2 downto 0) := "011";
	
	--Compara se as entradas sao iguais
	constant Cmp : std_logic_vector(2 downto 0) := "100";
	
begin

	igual <= '1' when (to_integer(unsigned(A AND B)) /= 0) else '0'; 
	 -- Nao tem overflow
	SAIDA : with func select
	C <= std_logic_vector(unsigned(A) + unsigned(B)) when Add,
		  std_logic_vector(unsigned(A) - unsigned(b)) when Sub,
		  B when RetB,
          A when RetA,
		  (others=>'0') when others;

	IGUAL_Select : with func select
	equal <= igual when Cmp,
					'0' when others;

	
end Arch;
