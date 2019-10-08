library ieee;
use ieee.std_logic_1164.all;

entity cpu is
    generic (
        larguraBarramentoEnderecos  : natural := 8;
        larguraBarramentoDados      : natural := 8
    );
    port
    (
        clk                     : IN  STD_LOGIC;
        barramentoDadosEntrada  : IN STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
        barramentoEnderecos     : OUT STD_LOGIC_VECTOR(larguraBarramentoEnderecos-1 DOWNTO 0);
        barramentoDadosSaida    : OUT STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
        readEnable              : OUT STD_LOGIC;
        writeEnable             : OUT STD_LOGIC
    );
end entity;

architecture estrutural of relogio is

    -- Declaração de sinais auxiliares
    signal entradaA_MUX, entradaA_MUX, saida_MUX, entrada_somador, saida_somador : STD_LOGIC_VECTOR(larguraBarramentoDados-1 DOWNTO 0);
    signal seletor_MUX : STD_LOGIC;
    -- ...

begin

    -- Exemplos de instanciação de componentes

    -- Instanciação de Banco de Registradores
    BR : entity work.bancoRegistradores 
    generic map (
        larguraDados    => larguraBarramentoDados
    )
    port map
    (
        clk                 => clk,
        enderecoA           => enderecoA,
        enderecoB           => enderecoB,
        enderecoC           => enderecoC,
        dadoEscritaC        => dadoEscritaC,
        escreveC            => escreveC,
        saidaA              => saidaA,
        saidaB              => saidaB
    );

    -- Instanciação de Banco de Registradores
    PC : entity work.RegFlipFlop  
    -- generic map (
    -- );
    port map
    (
        clk         => clk,
        enable      => enable_pc,
        reset       => reset_pc,
        DIN         => entrada_pc,
        DOUT        => saida_pc
    );

    -- Instanciação de MUX
    MUX1 : entity work.mux 
    generic map (
        larguraDados    => larguraBarramentoDados
    )
    port map
    (
        entradaA_MUX            => entradaA_MUX,
        entradaB_MUX            => entradaB_MUX,
        seletor_MUX             => seletor_MUX,
        saida_MUX               => saida_MUX
    );
    
    -- ...

    -- Instanciação de Somador com Constante
    SOMADOR1 : entity work.somador 
    generic map (
        larguraDados    => larguraBarramentoDados,
        incremento      => 4
    )
    port map
    (
        entrada         => entrada_somador,
        saida           => saida_somador
    );
    
    -- Completar com a instanciação de demais 
    -- componentes necessários

end architecture;