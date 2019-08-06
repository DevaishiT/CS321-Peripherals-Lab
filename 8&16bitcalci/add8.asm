cpu "8085.tbl"
hof "int8"

org 9000h

;c has the operation
dcr c
jz ADD
dcr c
jz SUB
dcr c
jz MUL
dcr c
jz DIV
jmp Over

;if c=01
ADD:
    ;inputs are taken in a and b registers
    add b
    sta 9501h
    jc loop1

    mvi a,0h
    sta 9500h
    jmp Over

    loop1:
    mvi a,1h
    sta 9500h
    ;value is stored in memory location 9501 and carry is stored in 9500
    jmp Over 

SUB:
    ;inputs are taken in a and b registers
    sub b
    sta 9501h
    mvi a,0h
    sta 9500h
    ;value is stored in memory location 9501
    jmp Over

MUL:
    ;inputs are taken in b and e
    mvi a,00h ;answer
    mvi d,00h ;carry-over
    cmp e
    jz zero
    loop2: add b
    jnc next2
    inr d
    next2: dcr e
    jnz loop2
    sta 9501h 
    mov a,d
    sta 9500h
    jmp Over 
    ;if e=0
    zero: sta 9500h
    sta 9501h

    ; value is in 9501h and overflow is in 9500h 
    jmp Over

DIV:
    ;inputs are in a and b
    mvi e,00h
    next: cmp b
    jc loop
    sub b
    inr e
    jmp next
    loop: sta 9500h
    mov a,e
    sta 9501h
    ; remainder is stored in 9500h and quotient is stored in 9501h

Over: RST 5