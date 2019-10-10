library ieee;
use ieee.std_logic_1164.all;

entity Relogio is
    generic (
        larguraBarramentoEnderecos  : natural := 8;
        larguraBarramentoDados      : natural := 4;
        quantidadeLedsRed           : natural := 18;
        quantidadeLedsGreen         : natural := 8;
        quantidadeChaves            : natural := 18;
        quantidadeBotoes            : natural := 4;
        quantidadeDisplays          : natural := 8
    );
    port
    (
        CLOCK_50 : IN STD_LOGIC;
        -- BOTOES
        --KEY: IN STD_LOGIC_VECTOR(quantidadeBotoes-1 DOWNTO 0);
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
    signal sig_endereco             : STD_LOGIC_VECTOR(larguraBarramentoEnderecos-1 DOWNTO 0);
    signal sig_somador              : STD_LOGIC_VECTOR(larguraBarramentoEnderecos-1 DOWNTO 0);
	 signal sig_instrucao            : STD_LOGIC_VECTOR(11 DOWNTO 0);
    signal saidaMuxJump             : STD_LOGIC_VECTOR(larguraBarramentoEnderecos-1 DOWNTO 0);
    signal saidaMuxULA   : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
    signal saidaULA   : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
    signal saidaBancoReg   : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
    signal saidaIO   : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
	 signal saidaVel1 : std_logic;
	 signal saidaVel2 : std_logic;

    -- Sinais de controle RD/WR
    signal readEnableDisplay               : STD_LOGIC;
    signal writeEnableDisplay              : STD_LOGIC;

    -- Sinais de habilitacao dos componentes
    signal habilitaDisplay          : STD_LOGIC_VECTOR(quantidadeDisplays-1 DOWNTO 0);
    --signal habilitaLedsRed          : STD_LOGIC_VECTOR(quantidadeLedsRed-1 DOWNTO 0);
    signal habilitaLedsGreen        : STD_LOGIC_VECTOR(quantidadeLedsGreen-1 DOWNTO 0);
    signal habChaves           : STD_LOGIC;
    signal habilitaBaseTempo        : STD_LOGIC;
    signal habilitaBanco          : std_logic;
	 signal sig_equal: std_logic_vector(2 downto 0);
	 signal sig_ULA_func: std_logic_vector(2 downto 0);
	 signal habilita_Banco: std_logic;
	 signal Mux_entradaULA: std_logic;
	 signal mux_jump: std_logic;

    -- Sinais auxiliares
    signal entradaDisplays          : STD_LOGIC_VECTOR(quantidadeDisplays-1 DOWNTO 0);
    --signal entradaLedsRed           : STD_LOGIC_VECTOR(quantidadeLedsRed-1 DOWNTO 0);
    signal entradaLedsGreen         : STD_LOGIC_VECTOR(quantidadeLedsGreen-1 DOWNTO 0);
    signal saidaBotoes              : STD_LOGIC_VECTOR(quantidadeBotoes-1 DOWNTO 0);
	 signal saidaMUXClock     : STD_LOGIC;
    signal saidaClock     : STD_LOGIC_vector (3 downto 0);
	 signal sig_clear : std_logic;
	 signal testeClock : std_logic;
begin




		LEDG <= sig_endereco;
		
		
    DE : entity work.decoder 
    port map
    (
	    endereco        => sig_instrucao(3 downto 0),
	    readEnable      => readEnableDisplay,
	    writeEnable     => writeEnableDisplay,
		 eseg70 => habilitaDisplay(0),
		 eseg71 => habilitaDisplay(1), 
		 eseg72 => habilitaDisplay(2), 
		 eseg73 => habilitaDisplay(3), 
		 eseg74 => habilitaDisplay(4), 
		 eseg75 => habilitaDisplay(5), 
		 eseg76 => habilitaDisplay(6), 
		 eseg77 => habilitaDisplay(7),
		 esw => habChaves,
		 ebt => habilitaBaseTempo,
		 clear => sig_clear
    );	 
	 
    ROM : entity work.rom 
    port map
    (
          Endereco => sig_endereco,
          Dado => sig_instrucao
    );
	 
	PR: entity work.Processador 	 
	port map
	(
		CLK => CLOCK_50,
		Endereco => sig_instrucao(7 downto 0),
		Opcode => sig_instrucao(11 downto 8),
		DataIO => saidaClock,
		DataOut => saidaULA,
		ReadIO => readEnableDisplay,
		WriteIO => writeEnableDisplay,
		OutEnd => sig_endereco
	);
	--LEDR(17 downto 10) <= sig_endereco;

    -- Instanciação do componente Divisor Genérico
        -- Componente da composição da Base de Tempo
    BASE_TEMPO2 : entity work.divisorGenerico 
    port map
    (
        clk             => CLOCK_50,
        saida_clk       => saidaVel1
    );
	 
    -- Instanciação do componente Divisor Genérico
        -- Componente da composição da Base de Tempo
    BASE_TEMPO3 : entity work.divisorGenerico2 
    port map
    (
        clk             => CLOCK_50,
        saida_clk       => saidaVel2
    );
	 
	 Mux_Vel: entity work.muxVel
	 port map
	 (
		 A => saidaVel1,
       B => saidaVel2,		 
		 sel => SW(17),
		 X => saidaMUXClock
	 );
	 
	 
	 tf: entity work.fliflopRESET
	 port map
	 (
		d => "0001",
		clk => saidaMUXClock,
		reset => sig_clear,
      saida_clk => saidaClock
	 );	 
	 
	 
    -- Instanciação de cada Display
    DISPLAY0 : entity work.conversorHex7SegDisplay 
    port map
    (
        clk         => CLOCK_50,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    => habilitaDisplay(0),
        saida7seg   => HEX2
    );

    -- Instanciação de cada Display
    DISPLAY1 : entity work.conversorHex7SegDisplay  
    port map
    (
        clk         => CLOCK_50,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    =>  habilitaDisplay(1),
        saida7seg   => HEX3
    );
    -- Instanciação de cada Display
    DISPLAY2 : entity work.conversorHex7SegDisplay  
    port map
    (
        clk         => CLOCK_50,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    =>  habilitaDisplay(2),
        saida7seg   => HEX4
    );
    -- Instanciação de cada Display
    DISPLAY3 : entity work.conversorHex7SegDisplay  
    port map
    (
        clk         => CLOCK_50,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    =>  habilitaDisplay(3),
        saida7seg   => HEX5
    );
    -- Instanciação de cada Display
    DISPLAY4 : entity work.conversorHex7SegDisplay  
    port map
    (
        clk         => CLOCK_50,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    =>  habilitaDisplay(4),
        saida7seg   => HEX6
    );
    -- Instanciação de cada Display
    DISPLAY5 : entity work.conversorHex7SegDisplay  
    port map
    (
        clk         => CLOCK_50,
        dadoHex     => saidaULA, -- que veio da ULA
        habilita    =>  habilitaDisplay(5),
        saida7seg   => HEX7
    );
    -- Instanciação de cada Display
    DISPLAY6 : entity work.conversorHex7SegDisplay  
    port map
    (
        clk         => CLOCK_50,
        dadoHex     => "0000", 
        habilita    => '1',
        saida7seg   => HEX1
    );    -- Instanciação de cada Display
    DISPLAY7 : entity work.conversorHex7SegDisplay  
    port map
    (
        clk         => CLOCK_50,
        dadoHex     => "0000",
        habilita    => '1',
        saida7seg   => HEX0
    );
--    -- Instanciação das Chaves
--    IO : entity work.io 
--    port map
--    (
--        entradaChaves   => SW(1 DOWNTO 0),
--		  entradaBaseTempo => saidaClock,
--		  habilitaBaseTempo => habilitaBaseTempo,
--        --habilitaChaves        => habChaves,
--		  --Vel => ,
--        saida           => saidaIO
--    );
	 
end architecture;