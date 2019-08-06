cpu "8085.tbl"
hof "int8"

org 9000h

;operation is taken in register a
dcr a
jz ADD
dcr a
jz SUB
dcr a
jz MUL
dcr a
jz DIV
jmp Over
ADD:
    ;lower part of first a and second b
    ;upper part of first c and second d
    ; ca and db
    add b 
    sta 9502h
    mov a,c
    adc d
    sta 9501h
    jc loop1
    mvi a,0h
    sta 9500h
    jmp Over
    loop1:
    mvi a,1h
    sta 9500h
    ;value is stored in 9501h and 9502h and carry is stored in 9500h
    jmp Over 

SUB:
    ;the numbers are de and hl
    mov a,l
    sub e
    ;mov l,a
    sta 9502h
    mov a,h
    sbb d ;a-d-cy
    ;mov h, a
    sta 9501h
    mvi a,0h
    sta 9500h
    ;value is stored in 9501h and 9502h 
    jmp Over

MUL:
    ;9500 and 9502 address has values
    lhld 9500h
    ;save the content of HL in stack pointer.
    sphl
    lhld 9502h
    ;values of hl and de are exchanged
    xchg
    lxi h,0000h
    lxi b,0000h
    ; dad adds the contents of sp to hl
    lab1: dad sp
    jnc lab2
    ;bc will store the first 16bits
    inx b
    lab2: dcx d
    ;checking if de is 0
    mov a,e
    ora d
    jnz lab1
    shld 9504h
    mov l,c
    mov h,b
    shld 9506h
    ;values are stored from 9504h-9507h
    jmp Over

DIV:
    ;de and hl are the numbers


    mov b,00h
    mov c,00h
    
    label: mov a,l
    sub e
    mov l,a
    mov a,h
    sbb d
    mov h,a
    jc label2
    inx b ;pair is incremented
    jmp label
    label2: dad d ;de+hl is needed
    ;bc is the quotient and hl is the remainder
    jmp Over

Over: RST 5