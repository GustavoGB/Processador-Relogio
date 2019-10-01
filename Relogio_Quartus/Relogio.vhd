library ieee;
use ieee.std_logic_1164.all;

entity relogio is
    generic (
        larguraBarramentoEnderecos  : natural := 8;
        larguraBarramentoDados      : natural := 8;
        quantidadeLedsRed           : natural := 18;
        quantidadeLedsGreen         : natural := 8;
        quantidadeChaves            : natural := 18;
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

architecture estrutural of relogio is

    -- Sinais de barramentos
    signal barramentoEnderecos      : STD_LOGIC_VECTOR(larguraBarramentoEnderecos-1 DOWNTO 0);
    signal barramentoDadosEntrada   : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
    signal barramentoDadosSaida     : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
    
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

    -- Sinais auxiliares
    signal entradaDisplays          : STD_LOGIC_VECTOR(quantidadeDisplays-1 DOWNTO 0);
    signal entradaLedsRed           : STD_LOGIC_VECTOR(quantidadeLedsRed-1 DOWNTO 0);
    signal entradaLedsGreen         : STD_LOGIC_VECTOR(quantidadeLedsGreen-1 DOWNTO 0);
    signal saidaChaves              : STD_LOGIC_VECTOR(quantidadeChaves-1 DOWNTO 0);
    signal saidaBotoes              : STD_LOGIC_VECTOR(quantidadeBotoes-1 DOWNTO 0);
    signal saidaDivisorGenerico     : STD_LOGIC;

begin

    -- Instanciação da CPU
    CPU : entity work.cpu 
    port map
    (
        clk                     => clk,
        barramentoDadosEntrada  => barramentoDadosEntrada,
        barramentoEnderecos     => barramentoEnderecos,
        barramentoDadosSaida    => barramentoDadosSaida,
        readEnable              => readEnable,
        writeEnable             => writeEnable
    );
    
    -- Instanciação do Decodificador de Endereços
        -- A entidade do decodificador fica a criterio do grupo
        -- o portmap a seguir serve como exemplo
    DE : entity work.decodificador_enderecos 
    port map
    (
        endereco        => endereco,
        readEnable      => readEnable,
        writeEnable     => writeEnable,
        habilitaDisplay => habilitaDisplay,
        habilitaLedsRed => habilitaLedsRed
        -- ...
    );

    -- Instanciação do componente Divisor Genérico
        -- Componente da composição da Base de Tempo
    BASE_TEMPO : entity work.divisorGenerico 
    port map
    (
        clk             => clk,
        saida_clk       => saidaDivisorGenerico
    );

    -- Instanciação de cada Display
    DISPLAY0 : entity work.display7Seg 
    port map
    (
        clk         => clk,
        dadoHex     => entradaDisplays,
        habilita    => habilitaDisplay(0),
        saida7seg   => HEX0
    );

    DISPLAY1 : entity work.display7Seg 
    port map
    (
        clk         => clk,
        dadoHex     => entradaDisplays,
        habilita    => habilitaDisplay(1),
        saida7seg   => HEX1
    );

    --...

    -- Instanciação dos LEDs vermelhos
    LEDR : entity work.leds 
    generic map (
        quantidadeLeds  => quantidadeLedsRed
    );
    port map
    (
        clk         => clk,
        dados       => entradaLedsRed,
        habilita    => habilitaLedsRed,
        saidaLeds   => LEDR(quantidadeLedsRed-1 DOWNTO 0)
    );

    -- Instanciação dos LEDs verdes
    LEDG : entity work.leds 
    generic map (
        quantidadeLeds  => quantidadeLedsGreen
    );
    port map
    (
        clk         => clk,
        dados       => entradaLedsGreen,
        habilita    => habilitaLedsGreen,
        saidaLeds   => LEDG(quantidadeLedsGreen-1 DOWNTO 0)
    );

    -- Instanciação das Chaves
    CHAVES : entity work.chaves 
    generic map (
        quantidadeChaves    => quantidadeChaves
    );
    port map
    (
        entradaChaves   => SW(quantidadeChaves-1 DOWNTO 0),
        habilita        => habilitaChaves,
        saida           => saidaChaves,
    );

    -- Instanciação dos Botões
    BOTOES : entity work.botoes 
    generic map (
        quantidadeBotoes    => quantidadeBotoes
    );
    port map
    (
        entradaBotoes   => KEY(quantidadeBotoes-1 DOWNTO 0),
        habilita        => habilitaBotoes,
        saidaBotoes     => saidaBotoes
    );

    -- Completar com a instanciação de demais componentes necessários 
    -- e ligações entre os sinais auxiliares de saida/entrada e os barramentos da CPU

end architecture;