# Processador-Relogio
Design de Computadores sexto semestre. 

Relatório Intermediário

    Pseudocódigo do relógio;

    Total de instruções e sua sintaxe;

    Modos de endereçamento utilizados;

    Formato das instruções;

    Arquitetura do processador;

    Fluxo de dados para o processador, com uma explicação resumida do seu funcionamento;

    Listagem dos pontos de controle e sua utilização;

    Diagrama de conexão do processador com os periféricos;

    Mapa de memória.


`` 1)Pseudocódigo está nos arquivos relogio.c e relogio.s ``

 ``Ainda precisamos escrever um loop principal em Assembly que espera o valor do registrador(que vira 1 quando passa 1 segundo via hardware) e, quando o valor for 1, dar um jmp para o Assembly já feito. Ao final do Assembly, voltar para o 
 loop principal ``

 ```c
 #include <stdio.h>
#include <stdlib.h>
int main(){
    int seg1 = 0;
    int seg2 = 0;
    int min1 = 0;
    int min2 = 0;
    int h1 = 0;
    int h2 = 0;

    while(1){
        while( h2!=2 || h1!=4 ){
            while(min2!=5 || min1!=9){
                while( seg2!=5 || seg1!=9 ){
                        if(seg1<9){
                            seg1++;
                            //printf("%d%d:%d%d:%d%d\n", h2, h1, min2, min1, seg2, seg1);
                            //sleep(0,3);
                        }
                        else{
                            seg1 = 0;
                            if(seg2<5) seg2++;
                            //printf("%d%d:%d%d:%d%d\n", h2, h1, min2, min1, seg2, seg1);
                            //sleep(0,3);
                        }
                }
                seg1 = 0;
                seg2 = 0;
                if(min1 < 9) min1++;
                else{
                    min1 = 0;
                    min2++;
                }
            }
            min1 = 0;
            min2 = 0;
            if(h1<9) h1++;
            else{
                h1 = 0;
                h2++;
            }
        }
        h1 = 0;
        h2 = 0;
    }
}
```

``Total de instruções e sua sintaxe;``

    No código 
