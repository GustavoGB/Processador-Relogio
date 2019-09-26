	.file	"relogio.c"
	.text
	.globl	main
	.type	main, @function

main:

.CLOCK:
	movr $0, %fim
	cmpio $1, %btempo; COMPARANDO O REGISTRADOR DO CLOCK
	je .LFB41
	jmp .CLOCK ;ENQUANTO NÃO PASSAR UM SEGUNDO CONTINUA AQUI

.LFB41:
	.cfi_startproc
	movr	$0, %edi
	movr	$0, %esi
	jmp	.L13
.L18: 
	cmp	$8, %ecx ;INCREMENTA OS MINUTOS SE M1 E M2 NÃO FOREM 59
	jg	.L7
	add	$1, %ecx
	cmp	$5, %r8d
	jne	.L12
	cmp	$9, %ecx
	jne	.L12
	cmp	$8, %esi
	jg	.L10
	add	$1, %esi ; INCREMENTA AS HORAS SE M1 E M2 FOREM 5 E 9 E H1 DIFERENTE DE 9
	; SE H1 FOR 9 VAI PRA L10

.L13: ; CHECA SE H2 != 2 E H1 != 4, SE FOR VAI PRA L13, MAS DEPOIS DE ZERAR HRS E MINS
	cmp	$2, %edi
	jne	.L15 ; NOT EQUAL
	cmp	$4, %esi
	jne	.L15
	movr	$0, %edi
	movr	$0, %esi
	jmp	.L13
.L7:
	add	$1, %r8d
	movr	$0, %ecx
.L12: ;VEM AQUI DPS DE ZERAR OS MINUTOS
	movr	$0, %edx ; ZERA OS SEGUNDOS
	movr	$0, %eax
.L14:
	cmp $1, %fim ;verifica se terminou uma iteração
	je .CLOCK; volta para o loop do clock
	add	$1, %eax ;SOMA UM SEG1
	movr $1, %fim
.L5:
	cmp	$5, %edx ; CHECA SE SEGUNDOS 1 E 2 SÃO 5 E 9
	jne	.L6 ;SE S2 FOR 5 ELE CHECA S1 PRA VER SE É 9
	;SE NÃO FOR VAI PRA L6 DIRETO
	cmp	$9, %eax
	je	.L18 ; SE S1 FOR 9 ELE VAI PRA L18 INCREMENTAR S2
.L6:
	cmp	$8, %eax
	jle	.L14
	movr	$0, %eax
	cmp	$4, %edx
	jg	.L5
	add	$1, %edx
	jmp	.L5
.L10:
	add	$1, %edi ; INCREMENTA H2, SE CHEGOU AQUI H1 É 9
	movr	$0, %esi ; ZERA H1
	jmp	.L13
.L15: ;CHEGA AQUI DPS DE VERIFICAR AS HORAS
; INICIALIZA MINUTOS
	movr	$0, %r8d
	movr	$0, %ecx
	jmp	.L12
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
