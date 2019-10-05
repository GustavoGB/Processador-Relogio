# Processador-Relogio
Design de Computadores sexto semestre. 

Relatório Intermediário

    Pseudocódigo do relógio;

    Total de instruções e sua sintaxe;

    Formato das instruções;

    Modos de endereçamento utilizados;

    Arquitetura do processador;

    Diagrama de conexão do processador com os periféricos;

    Fluxo de dados para o processador, com uma explicação resumida do seu funcionamento;

    Listagem dos pontos de controle e sua utilização;

    Mapa de memória. (Nossa arquitetura não possui RAM); 


`` 1)Código em assembly está nos arquivos relogio2.c  ``


#
*Código assembly do modelo*

```asm
.INIT:
	movr $0, %s1
	movr $0, %s2
	movr $0, %m1
	movr $0, %m2
	movr $0, %h1
	movr $0, %h2
.CLOCK:
    loadio $27, %chave1
    loadio $28, %chave2
    loadio $29, %chave3
    loadio $25, %btempo
	cmp $1, %btempo 
	jne .CLOCK 
    movd $26, %btempo 
    cmp $1, %chave1
    je .CHAVE1
    cmp $1, %chave2
    je .CHAVE2
    cmp $1, %chave3
    je .CHAVE3
    jmp .CHAVE0 
.CHAVE0:
.SEGUNDOS:
    add $1, %s1
    cmp $10, %s1
    je .S2
    jmp .DISPLAY
.S2:
    movr $0, %s1
    add $1, %s2
    cmp $6, %s2
    je .M1
    jmp .DISPLAY
.M1:
    movr $0, %s2
    add $1, %m1
    cmp $10, %m1
    je .M2
    jmp .DISPLAY
.M2:
    movr $0, %m1
    add $1, %m2
    cmp $6, %m2
    je .H1
    jmp .DISPLAY

.H1:
    movr $0, %m2
    add $1, %h1
    cmp $5, %h1
    je .H2
    jmp .DISPLAY
.H2:
    movr $0, %h1
    add $1, %h2
    cmp $3, %h2
    je .VOLTA
    jmp .DISPLAY
.VOLTA:
    movr $0, %s1
    movr $0, %s2
    movr $0, %m1
    movr $0, %m2
    movr $0, %h1
    movr $0, %h2
    jmp .DISPLAY
.CHAVE1:
    jmp .DISPLAY
.CHAVE2:
    jmp .DISPLAY
.CHAVE3:
    jmp .DISPLAY
.DISPLAY:
	movd $17, %s1
	movd $18, %s2
	movd $19, %m1
	movd $20, %m2
	movd $21, %h1
	movd $22, %h2
    jmp .CLOCK
 ```
 #

Portanto nossa arquitetura possui 16 registradores, mas vamos utilizar apenas 10 para o relógio. 

`` 2) Total de instruções e sua sintaxe;``

    | Instruções                  |Binário  |
    | MOVR  | (move)              | 0000    |
    | JMP   | (jump)              | 0001    |  
    | CMP   |  (compare)          | 0010    |
    | ADD   | (add a+b )          | 0011    |
    | JNE   | (jump  if< 0)       | 0100    |
    | JE    | (jump equal a=b)    | 0101    |
    | SUB   | (sub a-b)           | 0110    |
    | MOVD  | (move LCD)          | 0111    | 
    | LOADIO|(carrega valor do IO)| 1000    | 



* O total de instruções é 9. 

* Elas possuem o seguinte formato :

| OPCODE        | REGISTRADOR   | RESERVADO | 
| ------------- | ------------- | --------- |
| 4bits  | 4bits  | 5bits|


``     Modos de endereçamento e mapeamento do I/O ``

* Endereçamento imediato

    * Exemplo:
     ```asm

      IMEDIATO:

      movr $0, %ecx

      LCD:

      movd $18 , %s2   (18 é o endereço do primeiro algarismo dos segundos)    

      movd carrega um registrador e manda pra entrada da ULA, seleciona a função para transferir essa entrada direto para a saída, esse dado vai para o I/O e a escrita no mesmo vai estar habilitada porque a unidade de controle irá habilitá-la ao ver que a instrução é do tipo movd)

      CARREGA I/O valor do periféricos:

      loadio $27, %chave1 (27 endereço da chave 1)

      BASE DE TEMPO:

      loadio %25, %btempo  (25 é o endereço da base de tempo)

      CLEAR:
      movd %btempo, %26  (26 é endereço da btempo sabendo que ele tem 1)
      

      
    (Coloca o conteúdo do edi na primeiro segmento do display)
     ```

```   3) Arquitetura do processador; ```

* Para este projeto estaremos utilizando uma arquitetura Registrador-Memória.

O processo de decisão da arquitetura do relógio foi baseado no assembly feito. No momento em que realizamos a conversão, percebemos que todas as instruções necessárias para o funcionamento integral do relógio poderiam ser executadas através de operações entre um registrador e um imediato. Nesse sentido, usamos a instrução *movr*, que é responsável por buscar o conteúdo de um registrador específico do banco de registradores e realizar alguma operação deste com um imediato.



``` 4) Diagrama de conexão do processador com os periféricos;```

![](diagramaBasico.jpg)


``` 5)Fluxo de dados para o processador, com uma explicação resumida do seu funcionamento;```

Explicação do fluxo de dados:

    A partir de uma determinada instrução, esperamos a leitura do registrador da base de tempo indicar que um segundo já passou para executar o loop de instruções desencadeado pelo add de um no registrador do primeiro dígito dos segundos. 

    Considerando essa mesma instrução add, por exemplo, o assembler transforma o conteúdo do program counter em uma instrução (Opcode + End[reg] + Imediato). Em seguida, envia-se essa instrução para a unidade de controle e a mesma gera os pontos de controle específicos para a execução deste comando. 

    Enquanto o imediato vai para a ULA, a instrução também vai para o banco de registradores, onde o conteúdo do endereço do registrador em questão é procurado e enviado para a entrada inferior da ULA. No caso dos registradores do display, os mesmos não estarão habilitados a menos que a instrução seja movd, o que impede escritas involuntárias.

    Na ULA, a operação add é executada entre o imediato e o conteúdo que foi devolvido pelo banco de registradores. O resultado é armazenado no mesmo registrador envolvido na operação.

   ``` 6) Listagem dos pontos de controle e sua utilização```
    
   * ULA_func:

     1)   add
     2)   sub
     3)   and
     4)   movr
     5)   movd
     6)   loadio        
   * Habilita_BancoRegistradores
   * Mux entrada_ULA
   * Habilita_I/O
   * Mux Jump

   
   

