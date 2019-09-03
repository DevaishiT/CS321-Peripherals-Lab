cpu "8085.tbl"
hof "int8"
RDKBD: EQU 03BAH
driver: equ 8450h
org 9300H
CALL RDKBD
cpi 1
jz one
cpi 2
jz two
cpi 3
jz three
cpi 4
jz four
cpi 5
jz five
jmp 9300h
one:
    mvi b, 50h
    jmp start
two:
    mvi b, 25h
    jmp start
three:
    mvi b, 18h
    jmp start
four:
    mvi b, 10h
    jmp start
five:
    mvi b, 0cH
    jmp start

start:
    XRA A
L1:
    OUT 00H; 8C05
    OUT 01H
    CALL DELAY
    ADI 40H
    CPI 00H
    JNZ L1
    XRA A
    OUT 00H
    OUT 01H
    CALL DELAY
; L2:
;     OUT 00H; 8C0F
;     OUT 01H
;     CALL DELAY
;     DCR A
;     JNZ L2

    IN 41h
    cpi 00001000b
    jz start
    JMP driver

DELAY: 
    MOV C, B
LOOP:
    DCR C
    JNZ LOOP
    RET