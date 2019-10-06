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
    movd %btempo, $26 
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