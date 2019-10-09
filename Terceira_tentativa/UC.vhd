-- does not create the library; it simply forward declares 
-- it. 
library ieee;

-- Use clauses import declarations into the current scope.	
-- If more than one use clause imports the same name into the
-- the same scope, none of the names are imported.

-- Import all the declarations in a package
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
	Generic ( largura_Dados : natural := 4 );
	
	port
	(
		igual : in std_logic_vector(2 downto 0);
		opcode : in std_logic_vector (largura_Dados-1 downto 0);
		ULA_func : out std_logic_vector (2 downto 0);
		Habilita_BancoRegistradores : out std_logic;
		Mux_entradaULA: out std_logic; -- 0=out I/O; 1=Imediato
		Habilita_IO: out std_logic;
		ReadEnableDisplay: out std_logic;
		Mux_Jump: out std_logic
	);
end UC;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture Arch of UC is
	constant jmp : std_logic_vector(3 downto 0) := "1001";
	constant je : std_logic_vector(3 downto 0) := "0101";
	constant jne : std_logic_vector(3 downto 0) := "0100";
	constant movd : std_logic_vector(3 downto 0) := "0111";
	constant movr : std_logic_vector(3 downto 0) := "0000";
	constant loadio : std_logic_vector(3 downto 0) := "1000";
	constant add : std_logic_vector(3 downto 0) := "0011";
	constant cmp : std_logic_vector(3 downto 0) := "0010";
	constant sub : std_logic_vector(3 downto 0) := "0110";
	
begin
	Mux_Jump <= '0' when (opcode = je and igual = "001")  or (opcode = jne and igual = "000") or (opcode = jmp) else '1';
	
	Habilita_BancoRegistradores <= '1' when (opcode = movr) or (opcode = loadio) or (opcode = add) else '0';
	
	
	
	ULA_func <= "000" when (opcode = add) else
		"001" when (opcode = sub) else
		"010" when (opcode = loadio) else--Retorna entrada A quando loadio
		"011" when (opcode = movd) else
		"100" when (opcode = cmp) else
		"010" when (opcode = movr) else "111"; --Sempre movemos o imediato para o banco, Retorna a entrada A quando movr

	Habilita_IO <= '1' when (opcode = movd) else '0';

	ReadEnableDisplay <= '1' when (opcode = loadio) else '0';

	Mux_entradaULA <= '1' when (opcode = add) or (opcode = movr) or (opcode = cmp) else '0';
		
end Arch;
