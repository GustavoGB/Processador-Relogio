	.file	"relogio.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB41:
	.cfi_startproc
	movl	$0, %edi
	movl	$0, %esi
	jmp	.L13
.L18:
	cmpl	$8, %ecx
	jg	.L7
	addl	$1, %ecx
	cmpl	$5, %r8d
	jne	.L12
	cmpl	$9, %ecx
	jne	.L12
	cmpl	$8, %esi
	jg	.L10
	addl	$1, %esi
.L13:
	cmpl	$2, %edi
	jne	.L15
	cmpl	$4, %esi
	jne	.L15
	movl	$0, %edi
	movl	$0, %esi
	jmp	.L13
.L7:
	addl	$1, %r8d
	movl	$0, %ecx
.L12:
	movl	$0, %edx
	movl	$0, %eax
.L14:
	addl	$1, %eax
.L5:
	cmpl	$5, %edx
	jne	.L6
	cmpl	$9, %eax
	je	.L18
.L6:
	cmpl	$8, %eax
	jle	.L14
	movl	$0, %eax
	cmpl	$4, %edx
	jg	.L5
	addl	$1, %edx
	jmp	.L5
.L10:
	addl	$1, %edi
	movl	$0, %esi
	jmp	.L13
.L15:
	movl	$0, %r8d
	movl	$0, %ecx
	jmp	.L12
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
