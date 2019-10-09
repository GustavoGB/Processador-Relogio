library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processador is
	Generic ( largura_Dados : natural := 4 );
	
	port
	(
		CLK : in std_logic;
		Endereco: in std_logic_vector(7 downto 0);
		Opcode: in std_logic_vector(3 downto 0);
		DataIO: in std_logic_vector(3 downto 0);
		DataOut: out std_logic_vector(3 downto 0);
		ReadIO: out std_logic;
		WriteIO: out std_logic;
		OutEnd: out std_logic_vector(7 downto 0)
	);
end Processador;

architecture Arch of Processador is
signal end_add : std_logic_vector(7 downto 0);
signal mux_jump : std_logic;
signal saidaMuxJump : std_logic_vector(7 downto 0);
signal sig_equal : std_logic_vector(2 downto 0);
signal sig_ULA_func : std_logic_vector(2 downto 0);
signal habilitaBanco : std_logic;
signal Mux_entradaULA : std_logic;
signal saidaULA: std_logic_vector(3 downto 0);
signal saidaPC: std_logic_vector(7 downto 0);
signal saidaMuxULA : std_logic_vector(3 downto 0);
signal saidaBancoReg : std_logic_vector(3 downto 0);
begin

	Somador: entity work.somador
		 port map
		 (
			A => saidaPC,
			X => end_add
		 );
		 
		 Mux2_Jump: entity work.mux
		 port map
		 (
			 A => Endereco,
			 B => end_add,		 
			 sel => mux_jump,
			 X => saidaMuxJump
		 );
		 
		 PC : entity work.pc 
		 port map
		 (
			clk => CLK,
			A => saidaMuxJump ,
			instrucao => saidaPC
		 );
		 
-- Instanciação da Unidade de Controle
    UC : entity work.UC 
    port map
    (
		igual => sig_equal,
		opcode => Opcode,
		ULA_func => sig_ULA_func,
		Habilita_BancoRegistradores => habilitaBanco,
		Mux_entradaULA => Mux_entradaULA,
		Habilita_IO => WriteIO,
		ReadEnableDisplay => ReadIO,
		Mux_Jump => mux_jump
    );
	
	 Mux_entrada_ULA: entity work.muxULA
	 port map
	 (
		 A => DataIO,
       B => Endereco(3 downto 0),		 
		 sel => Mux_entradaULA,
		 X => saidaMuxULA
	 );
	 
	 BR: entity work.BancodeRegistradores
	 port map(
        clk => CLK,
        endereco => Endereco(7 downto 4),
        dadoEscrita  => saidaULA,
        escreve    => habilitaBanco,
        saida      => saidaBancoReg
	 );
	 
    ULA : entity work.ula 
    port map
    (
		A => saidaMuxULA,
		B => saidaBancoReg,
		func => sig_ULA_func,
		C => saidaULA,
		-- Flag
		equal => sig_equal
    );
	 

	DataOut <= saidaULA;
	OutEnd <= saidaPC;
	
end Arch;
