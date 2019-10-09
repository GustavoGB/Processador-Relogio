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
	Generic ( largura_Dados : natural := 4 );
	
	port
	(
		A : in std_logic_vector (largura_Dados-1 downto 0);
		B : in std_logic_vector (largura_Dados-1 downto 0);
		func : in std_logic_vector (2 downto 0);
		C : out std_logic_vector (largura_Dados-1 downto 0);
		-- Flag
		equal : out std_logic_vector(2 downto 0)
	);
end ula;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture Arch of ula is
	signal set_igual : std_logic_vector(2 downto 0);
	
	constant Add : std_logic_vector(2 downto 0) := "000";
	constant Sub : std_logic_vector(2 downto 0) := "001";

	-- Transfere a entrada superior(A) para a saida da ULA(C)
    constant RetA : std_logic_vector(2 downto 0) := "010";
     -- Transfere a entrada inferior(B) para a saida da ULA(C)
	constant RetB : std_logic_vector(2 downto 0) := "011";
	
	--Compara se as entradas sao iguais
	constant Cmp : std_logic_vector(2 downto 0) := "100";
	
begin
	set_igual <= "001" when (to_integer(unsigned(A AND B)) > 0) else
		"000";
	
	C <= std_logic_vector(unsigned(A) + unsigned(B)) when (func = Add) else
		std_logic_vector(unsigned(A) - unsigned(b)) when (func = Sub) else
		B when (func = RetB) else
		A when (func = RetA) else "0000";
	
	equal <= set_igual when (func = Cmp) else "100";	  

end Arch;
