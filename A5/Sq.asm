cpu "8085.tbl"
hof "int8"
RDKBD: EQU 03BAH
driver: equ 8450h
org 9100H
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
jmp 9100h
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
    mvi a,00h
    out 00h
    out 01h
    call DELAY
    mvi a,0FFh
    out 00h
    out 01h
    call DELAY

    IN 41h
    cpi 00000010b
    jz start
    JMP driver

DELAY: 
    MOV C, B
LOOP:
    DCR C
    JNZ LOOP
    RET