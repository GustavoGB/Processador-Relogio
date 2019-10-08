library ieee;
use ieee.std_logic_1164.all;

entity Relogio is
    generic (
        larguraBarramentoEnderecos  : natural := 8;
        larguraBarramentoDados      : natural := 4;
        quantidadeLedsRed           : natural := 18;
        quantidadeLedsGreen         : natural := 8;
        quantidadeChaves            : natural := 3;
        quantidadeBotoes            : natural := 4;
        quantidadeDisplays          : natural := 8
    );
    port
    (
        CLK : IN STD_LOGIC;
        -- BOTOES
        KEY: IN STD_LOGIC_VECTOR(quantidadeBotoes-1 DOWNTO 0);
        -- CHAVES
        SW : IN STD_LOGIC_VECTOR(quantidadeChaves-1 downto 0);
        
        -- LEDS
        LEDR : OUT STD_LOGIC_VECTOR(quantidadeLedsRed-1 downto 0);
        LEDG : OUT STD_LOGIC_VECTOR(quantidadeLedsGreen-1 downto 0);
        -- DISPLAYS 7 SEG
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 downto 0)
    );
end entity;

architecture estrutural of Relogio is

    -- Sinais de barramentos
    signal barramentoEnderecos      : STD_LOGIC_VECTOR(larguraBarramentoEnderecos-1 DOWNTO 0);
    signal barramentoDadosEntrada   : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
    signal barramentoDadosSaida     : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
    signal sig_endereco     : STD_LOGIC_VECTOR(larguraBarramentoEnderecos-1 DOWNTO 0);
    signal sig_somador     : STD_LOGIC_VECTOR(larguraBarramentoEnderecos-1 DOWNTO 0);
	 signal sig_instrucao: STD_LOGIC_VECTOR(11 DOWNTO 0);
    signal saidaMuxULA   : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
    signal saidaULA   : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
    signal saidaBancoReg   : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
    
    -- Sinais de controle RD/WR
    signal readEnable               : STD_LOGIC;
    signal writeEnable              : STD_LOGIC;

    -- Sinais de habilitacao dos componentes
    signal habilitaDisplay          : STD_LOGIC_VECTOR(quantidadeDisplays-1 DOWNTO 0);
    signal habilitaLedsRed          : STD_LOGIC_VECTOR(quantidadeLedsRed-1 DOWNTO 0);
    signal habilitaLedsGreen        : STD_LOGIC_VECTOR(quantidadeLedsGreen-1 DOWNTO 0);
    signal habilitaChaves           : STD_LOGIC_VECTOR(quantidadeChaves-1 DOWNTO 0);
    signal habilitaBotoes           : STD_LOGIC_VECTOR(quantidadeBotoes-1 DOWNTO 0);
    signal habilitaBaseTempo        : STD_LOGIC;
	 signal sig_equal: std_logic_vector(2 downto 0);
	 signal sig_ULA_func: std_logic_vector(2 downto 0);
	 signal habilita_Banco: std_logic;
	 signal Mux_entradaULA: std_logic;
	 signal mux_jump: std_logic;

    -- Sinais auxiliares
    signal entradaDisplays          : STD_LOGIC_VECTOR(quantidadeDisplays-1 DOWNTO 0);
    signal entradaLedsRed           : STD_LOGIC_VECTOR(quantidadeLedsRed-1 DOWNTO 0);
    signal entradaLedsGreen         : STD_LOGIC_VECTOR(quantidadeLedsGreen-1 DOWNTO 0);
    signal saidaChaves              : STD_LOGIC_VECTOR(quantidadeChaves-1 DOWNTO 0);
    signal saidaBotoes              : STD_LOGIC_VECTOR(quantidadeBotoes-1 DOWNTO 0);
    signal saidaDivisorGenerico     : STD_LOGIC;

begin

    -- Instanciação da CPU
    CPU_Relogio : entity work.CPU 
    port map
    (
        clk => CLK,
        barramentoDadosEntrada  => barramentoDadosEntrada,
        barramentoEnderecos     => barramentoEnderecos,
        barramentoDadosSaida    => barramentoDadosSaida,
        readEnable              => readEnable,
        writeEnable             => writeEnable
    );
    
    -- Instanciação do Decodificador de Endereços
        -- A entidade do decodificador fica a criterio do grupo
        -- o portmap a seguir serve como exemplo
    DE : entity work.decoder 
    port map
    (
	    endereco        => sig_endereco,
	    readEnable      => readEnable,
	    writeEnable     => writeEnable,
		 eseg70, eseg71, eseg72, eseg73, eseg74, eseg75, eseg76, eseg77 => habilitaDisplay,
		 esw => habilitaBotoes,
		 ekey => habilitaChaves,
		 ebt => habilitaBaseTempo
    );
	 
	 Somador: entity work.somador
	 port map
	 (
		A => sig_endereco,
		clk => CLK,
		X => sig_somador
	 );
	 
	 Mux_Jump: entity work.mux
	 port map
	 (
		 A => saidaChaves,
       B => sig_somador,		 
		 sel => mux_jump,
		 X => saidaMuxJump
	 );
	 
	 PC : entity work.pc 
    port map
    (
	   clk => CLK,
      A => saidaMuxJump ,
      instrucao => sig_endereco
    );
	 
	 
    ROM : entity work.rom 
    port map
    (
          Endereco => sig_endereco,
          Dado => sig_instrucao
    );
	 	 
	 -- Instanciação da Unidade de Controle
    UC : entity work.UC 
    port map
    (
		igual => sig_equal,
		opcode => sig_instrucao(0 to 3),
		ULA_func => sig_ULA_func,
		Habilita_BancoRegistradores => habilitaBanco,
		Mux_entradaULA => Mux_entradaULA,
		Habilita_IO => habilitaDisplay,
		Mux_Jump => mux_jump
    );
	 
	 Mux_entrada_ULA: entity work.mux
	 port map
	 (
		 A => saidaChaves,
       B => sig_instrucao(8 to 11),		 
		 sel => Mux_entradaULA,
		 X => saidaMuxULA
	 );
	 
	 BR: entity work.BancodedeRegistradores
	 port map(
        clk => CLK,
        endereco => sig_instrucao(4 to 7),
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

    -- Instanciação do componente Divisor Genérico
        -- Componente da composição da Base de Tempo
    BASE_TEMPO : entity work.divisorGenerico 
    port map
    (
        clk             => CLK,
        saida_clk       => CLK
    );

    -- Instanciação de cada Display
    DISPLAY0 : entity work.display7Seg 
    port map
    (
        clk         => CLK,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    => habilitaDisplay(0),
        saida7seg   => HEX0
    );

    -- Instanciação de cada Display
    DISPLAY1 : entity work.display7Seg 
    port map
    (
        clk         => CLK,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    => habilitaDisplay(1),
        saida7seg   => HEX1
    );
    -- Instanciação de cada Display
    DISPLAY2 : entity work.display7Seg 
    port map
    (
        clk         => CLK,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    => habilitaDisplay(2),
        saida7seg   => HEX2
    );
    -- Instanciação de cada Display
    DISPLAY3 : entity work.display7Seg 
    port map
    (
        clk         => CLK,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    => habilitaDisplay(3),
        saida7seg   => HEX3
    );
    -- Instanciação de cada Display
    DISPLAY4 : entity work.display7Seg 
    port map
    (
        clk         => CLK,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    => habilitaDisplay(4),
        saida7seg   => HEX4
    );
    -- Instanciação de cada Display
    DISPLAY5 : entity work.display7Seg 
    port map
    (
        clk         => CLK,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    => habilitaDisplay(5),
        saida7seg   => HEX5
    );
    -- Instanciação das Chaves
    CHAVES : entity work.chaves 
    generic map (
        quantidadeChaves    => quantidadeChaves
    )
    port map
    (
        entradaChaves   => SW(quantidadeChaves-1 DOWNTO 0),
        habilita        => habilitaChaves,
        saida           => saidaChaves
    );

    -- Instanciação dos Botões
    -- Completar com a instanciação de demais componentes necessários 
    -- e ligações entre os sinais auxiliares de saida/entrada e os barramentos da CPU

end architecture;