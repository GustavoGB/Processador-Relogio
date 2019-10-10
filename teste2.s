.INIT:
	movr $0, %s1
	movr $0, %s2
.SEGUNDOS:
    add $1, %s1
    cmp $10, %s1
    je .S2
    jmp .DISPLAY
.S2:
    movr $0, %s1
    add $1, %s2
    cmp $6, %s2
    je .INIT
    jmp .DISPLAY
.VOLTA:
    movr $0, %s1
    movr $0, %s2
    jmp .DISPLAY
.DISPLAY:
	movd $0, %s1
	movd $1, %s2
    jmp .SEGUNDOS

