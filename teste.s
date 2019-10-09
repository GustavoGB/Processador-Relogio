.INIT:
loadio $6, %btempo
cmp $1, %btempo
jne .INIT
add $1, %s1
movd $2, %s2
jmp .INIT