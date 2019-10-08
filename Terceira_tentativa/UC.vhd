-- does not create the library; it simply forward declares 
-- it. 
library ieee;

-- Use clauses import declarations into the current scope.	
-- If more than one use clause imports the same name into the
-- the same scope, none of the names are imported.

-- Import all the declarations in a package
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
	process(opcode, igual)
	begin
		if (opcode = jmp) then
			Mux_Jump <= '1';
		else
		
			if (opcode = jne) then
				if (igual = "000") then
					Mux_Jump <= '1';
				else 
					Mux_Jump <= '0';
				end if;
			else
				if (opcode = je) then
					if (igual = "001") then
						Mux_Jump <= '1';
					else 
						Mux_Jump <= '0';
					end if;
				else 
					Mux_Jump <= '0';
				end if;
			end if;
		
		end if;
	end process;
	
	with opcode select Habilita_BancoRegistradores <=
		'1' when (movr or loadio or add),
		'0' when others;

	with opcode select ULA_func <= 
		"000" when add,
		"001" when sub,
		"010" when loadio,--Retorna entrada A quando loadio
		"011" when movd,
		"100" when cmp,
		"010" when movr,--Sempre movemos o imediato para o banco, Retorna a entrada A quando movr
		"111" when others;

	with opcode select Habilita_IO <= 
		'1' when movd,
		'0' when others;

	with opcode select ReadEnableDisplay <= 
		'1' when loadio,
		'0' when others;

	with opcode select Mux_entradaULA <= 
		'1' when (add or movr or cmp),
		'0' when others;
		
end Arch;
