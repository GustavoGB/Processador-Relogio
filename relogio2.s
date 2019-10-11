.INIT:
	movr $0, %s1
	movr $0, %s2
	movr $0, %m1
	movr $0, %m2
	movr $0, %h1
	movr $0, %h2
	movd $0, %s1
	movd $1, %s2
	movd $2, %m1
	movd $3, %m2
	movd $4, %h1
	movd $5, %h2
    movd $7, %btempo
    movr $10, %chave1
.CLOCK:
    loadio $6, %btempo
	cmp $1, %btempo 
	je .CLEAR
	cmp $9, %btempo 
	je .AMPM
    jmp .CLOCK
.CLEAR:
    movd $7, %btempo 
    movr $0, %chave1
    movd $12, %chave1
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
    cmp $4, %h1
    je .CHECK
    cmp $10, %h1
    je .H2
    jmp .DISPLAY
.CHECK:
    cmp $2, %h2
    je .VOLTA
    jmp .DISPLAY
.H2:
    movr $0, %h1
    add $1, %h2
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
.AMPM:
.CLEAR2:
    movd $7, %btempo
.CORRECT:
    cmp $1, %h2
    je .CHECK3
    cmp $2, %h2
    je .CHECK4
.SEGUNDOS2:
    movd $12, %chave1
    add $1, %s1
    cmp $10, %s1
    je .S22
    jmp .DISPLAY2
.S22:
    movr $0, %s1
    add $1, %s2
    cmp $6, %s2
    je .M12
    jmp .DISPLAY2
.M12:
    movr $0, %s2
    add $1, %m1
    cmp $10, %m1
    je .M22
    jmp .DISPLAY2
.M22:
    movr $0, %m1
    add $1, %m2
    cmp $6, %m2
    je .H12
    jmp .DISPLAY2

.H12:
    movr $0, %m2
    add $1, %h1
    cmp $3, %h1
    je .CHECK2
    cmp $10, %h1
    je .H22
    jmp .DISPLAY2
.CHECK2:
    cmp $1, %h2
    je .VOLTA2
    jmp .DISPLAY2
.H22:
    movr $0, %h1
    add $1, %h2
    jmp .DISPLAY2
.VOLTA2:
    movr $0, %s1
    movr $0, %s2
    movr $0, %m1
    movr $0, %m2
    movr $1, %h1
    movr $0, %h2
    cmp $10, %chave1
    je .TROCAP
    movr $10, %chave1
    movd $12, %chave1
    jmp .DISPLAY2
.TROCAP:
    movr $11, %chave1
    movd $12, %chave1
    jmp .DISPLAY2
.DISPLAY2:
	movd $0, %s1
	movd $1, %s2
	movd $2, %m1
	movd $3, %m2
	movd $4, %h1
	movd $5, %h2
    jmp .CLOCK
.CHECK3:
    cmp $3, %h1
    je .L13
    cmp $4, %h1
    je .L14
    cmp $5, %h1
    je .L15
    cmp $6, %h1
    je .L16
    cmp $7, %h1
    je .L17
    cmp $8, %h1
    je .L18
    cmp $9, %h1
    je .L19
    jmp .SEGUNDOS2
.CHECK4:
    cmp $0, %h1
    je .L20
    cmp $1, %h1
    je .L21
    cmp $2, %h1
    je .L22
    cmp $3, %h1
    je .L23
    cmp $4, %h1
    je .L24
    jmp .SEGUNDOS2
.L13:
    movr $0, %h2
    movr $1, %h1
    jmp .SEGUNDOS2
.L14:
    movr $0, %h2
    movr $2, %h1
    jmp .SEGUNDOS2
.L15:
    movr $0, %h2
    movr $3, %h1
    jmp .SEGUNDOS2
.L16:
    movr $0, %h2
    movr $4, %h1
    jmp .SEGUNDOS2
.L17:
    movr $0, %h2
    movr $5, %h1
    jmp .SEGUNDOS2
.L18:
    movr $0, %h2
    movr $6, %h1
    jmp .SEGUNDOS2
.L19:
    movr $0, %h2
    movr $7, %h1
    jmp .SEGUNDOS2
.L20:
    movr $0, %h2
    movr $8, %h1
    jmp .SEGUNDOS2
.L21:
    movr $0, %h2
    movr $9, %h1
    jmp .SEGUNDOS2
.L22:
    movr $1, %h2
    movr $0, %h1
    jmp .SEGUNDOS2
.L23:
    movr $1, %h2
    movr $1, %h1
    jmp .SEGUNDOS2
.L24:
    movr $1, %h2
    movr $2, %h1
    jmp .SEGUNDOS2

