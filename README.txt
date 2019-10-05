# Processador-Relogio
Design de Computadores sexto semestre. 

Relat�rio Intermedi�rio

    Pseudoc�digo do rel�gio;

    Total de instru��es e sua sintaxe;

    Formato das instru��es;

    Modos de endere�amento utilizados;

    Arquitetura do processador;

    Diagrama de conex�o do processador com os perif�ricos;

    Fluxo de dados para o processador, com uma explica��o resumida do seu funcionamento;

    Listagem dos pontos de controle e sua utiliza��o;

    Mapa de mem�ria. (Nossa arquitetura n�o possui RAM); 


`` 1)C�digo em assembly est� nos arquivos relogio2.c  ``


#
*C�digo assembly do modelo*

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
Utizando as rela��es antigas das itera��es do projeto, foi poss�vel separar o uso de cada registrador para nossa arquitetura como mostra a rela��o abaixo: 

* H2 : EDI
* H1 : ESI
* S2 : EDX
* S1 : EAX
* M2 : R8D
* M1 : ECX

Portanto vamos utilizar 6 registradores

`` 2) Total de instru��es e sua sintaxe;``

    | Instru��es                  |Bin�rio  |
    | MOVR  | (move)              | 0000    |
    | JMP   | (jump)              | 0001    |  
    | CMP   |  (compare)          | 0010    |
    | ADD   | (add a+b )          | 0011    |
    | JNE   | (jump  if< 0)       | 0100    |
    | JE    | (jump equal a=b)    | 0101    |
    | SUB   | (sub a-b)           | 0110    |
    | MOVD  | (move LCD)          | 0111    | 
    | LOADIO|(carrega valor do IO)| 1000    | 



* O total de instru��es � 9. 

* Elas possuem o seguinte formato :

| OPCODE        | REGISTRADOR   | RESERVADO | 
| ------------- | ------------- | --------- |
| 4bits  | 4bits  | 5bits|


``     Modos de endere�amento e mapeamento do I/O ``

* Endere�amento imediato

    * Exemplo:
     ```asm

      IMEDIATO:

      movr $0, %ecx

      LCD:

      movd $18 , %s2   (18 � o endere�o do primeiro algarismo dos segundos)    

      movd carrega um registrador e manda pra entrada da ULA, seleciona a fun��o para transferir essa entrada direto para a sa�da, esse dado vai para o I/O e a escrita no mesmo vai estar habilitada porque a unidade de controle ir� habilit�-la ao ver que a instru��o � do tipo movd)

      CARREGA I/O valor do perif�ricos:

      loadio $27, %chave1 (27 endere�o da chave 1)

      BASE DE TEMPO:

      loadio %25, %btempo  (25 � o endere�o da base de tempo)

      CLEAR:
      movd %btempo, %26  (26 � endere�o da btempo sabendo que ele tem 1)
      

      
    (Coloca o conte�do do edi na primeiro segmento do display)
     ```

```   3) Arquitetura do processador; ```

* Para este projeto estaremos utilizando uma arquitetura Registrador-Mem�ria.

O processo de decis�o da arquitetura do rel�gio foi baseado na convers�o do c�digo em assembly. No momento em que realizamos a convers�o, percebemos que todas as instru��es necess�rias para o funcionamento integral do rel�gio poderiam ser executadas atrav�s de opera��es entre um registrador e um imediato. Nesse sentido, usamos a instru��o mov, que � respons�vel por buscar o conte�do de um registrador espec�fico do banco de registradores e realizar alguma opera��o deste com um imediato.



``` 4) Diagrama de conex�o do processador com os perif�ricos;```


![](diagramaBasico.jpg)


``` 5)Fluxo de dados para o processador, com uma explica��o resumida do seu funcionamento;```

A imagem a baixo mostra um diagrama para o nosso rel�gio com os perif�ricos


Explica��o do fluxo de dados:

    A partir de uma determinada instru��o, esperamos a leitura do registrador da base de tempo indicar que um segundo j� passou para executar o loop de instru��es desencadeado pelo add de um no registrador do primeiro d�gito dos segundos. 

    Considerando essa mesma instru��o add, por exemplo, a memoria de instru��es transforma o conte�do do program counter numa instrucao (Opcode + End[reg] + Imediato). Em seguida, envia-se essa instru��o para a unidade de controle e a mesma gera os pontos de controle espec�ficos para a execucao deste comando. Depois, o demux escolhe se a instru��o vai para a ULA ou para o decoder de endere�os, ou seja, para todos os casos exceto os movlcd, o imediato vai para a ULA. 

    Enquanto o imediato vai para a ULA, a instru��o tamb�m vai para o banco de registradores, onde o conte�do do endere�o do registrador em quest�o � procurado e enviado para a entrada superior da ULA e tamb�m para os registradores do display. No caso dos registradores do display, os mesmos n�o estar�o habilitados a menos que a instru��o seja movlcd, o que impede escritas involunt�rias.

    Na ULA, a opera��o add � executada entre o imediato e o conte�do que foi devolvido pelo banco de registradores. O resultado � armazenado no mesmo registrador envolvido na opera��o.

   ``` 6) Listagem dos pontos de controle e sua utiliza��o```
    
   * Dmux ULA/Decoder
   * Opera��o
   * Write/Read
   * Mux Jump

