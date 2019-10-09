.INIT:
	movr $0, %s1
	movr $0, %s2
	movr $0, %m1
	movr $0, %m2
	movr $0, %h1
	movr $0, %h2
.CLOCK:
    loadio $6, %btempo
	cmp $4, %btempo 
	jne .CLOCK 
    movd $7, %btempo 
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
.DISPLAY:
	movd $0, %s1
	movd $1, %s2
	movd $2, %m1
	movd $3, %m2
	movd $4, %h1
	movd $5, %h2
    jmp .CLOCK