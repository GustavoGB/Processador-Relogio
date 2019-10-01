.file "relogio.c"
.text
.globl main
.type main, @function

main:

.INIT:
	movr $0, %s1
	movr $0, %s2
	movr $0, %m1
	movr $0, %m2
	movr $0, %h1
	movr $0, %h2

.CLOCK:
    movr $11011, %chave1
    movr $11100, %chave2
    movr $11101, %chave3
    movr $11001, %btempo


	cmpio $1, %btempo; COMPARANDO O REGISTRADOR DO CLOCK
	jne .CLOCK ;ENQUANTO NÃO PASSAR UM SEGUNDO CONTINUA AQUI
    cmp $1, %chave1
    je .CHAVE1
    cmp $1, %chave2
    je .CHAVE2
    cmp $1, %chave3
    je .CHAVE3
    jmp .CHAVE0 ;SE NENHUMA ESTIVER 1 VAI PRA NORMAL

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
    je .h1
    jmp .DISPLAY

.H1:
    movr $0, %m2
    add $1, %h1
    cmp $5, %h1
    je .h2
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
    movr $0, %H2
    jmp .DISPLAY

.CHAVE1: ;A FAZER
    jmp .DISPLAY
.CHAVE2: ; A FAZER
    jmp .DISPLAY
.CHAVE3: ; A FAZER
    jmp .DISPLAY

.DISPLAY:
	movd %eax, $10001
	movd %edx, $10010
	movd %ecx, $10011
	movd %r8d, $10100
	movd %esi, $10101
	movd %edi, $10111
    jmp .CLOCK