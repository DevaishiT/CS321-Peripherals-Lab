cpu "8085.tbl"
hof "int8"

org 9000h
GTHEX: EQU 030EH
HXDSP: EQU 034FH
OUTPUT:EQU 0389H
CLEAR: EQU 02BEH
RDKBD: EQU 03BAH

CURDT: EQU 8FF1H
UPDDT: EQU 044cH
CURAD: EQU 8FEFH
UPDAD: EQU 0440H

MVI A,00H
MVI B,00H

; initializing address fields ie hh:mm to 00:00
LXI H,8840H
MVI M,00H
LXI H,8841H
MVI M,00H
LXI H,8842H
MVI M,00H
LXI H,8843H
MVI M,00H

; displaying the initial value of address fields
LXI H,8840H
CALL OUTPUT

MVI A,00H
MVI B,00H
; taking input for initial time in hh:mm format
CALL GTHEX
; storing intial time in hl register pair
MOV H,D
MOV L,E

HOUR_CHECK:
    ; checking if initial hr>=24
    MOV A,H
	CPI 24H
    JC MIN_CHECK ;direct to min checking

SET_HOUR:
    ;setting hr to 00
	MVI H,00H
	;JC LOOP

MIN_CHECK:
    ; checking if initial min>=60
    MOV A,L
	CPI 60H
    JC LOOP

SET_MIN:
    ;setting min to 00
	MVI L,00H 

LOOP:

HR_MIN:
    ;value of the H-L pair is stored in CURAD

	SHLD CURAD
	MVI A,00H ;reset the value of accumulator

NEXT_SEC:
    ;storing the value of accumulator in CURDT
	STA CURDT 

    ;calling UPDAD and UPDDT to update the address and data field of the display
	CALL UPDAD
	CALL UPDDT

    ; calling the delay function to cause a delay of 1 sec
	CALL DELAY

    ;loading the sec in accumulator
	LDA CURDT

    ;incrementing the sec
	ADI 01H 
    ;converting it to binary coded decimal
	DAA 

    ;checking whether sec<60 in which case NEXT_SEC is run again
	CPI 60H
	JNZ NEXT_SEC

	LHLD CURAD
	MOV A,L
	ADI 01H
	DAA
	MOV L,A

    ;checking whether min<60 in which case HR_MIN is run again
	CPI 60H
	JNZ HR_MIN

	MVI L,00H
	MOV A,H
	ADI 01H
	DAA
	MOV H,A

    ;checking whether hr<24 in which case HR_MIN is run again
	CPI 24H
	JNZ HR_MIN

    ;if hr>24 clock is reset to 00:00
	LXI H,0000H
	JMP LOOP

;delay routine
DELAY:
	MVI C,03H
OUTLOOP:
	LXI D,9F00H
INLOOP:
	DCX D ;decrement reg pair by 1 
	MOV A,D
	ORA E ;logical OR operation with value of reg E
	JNZ INLOOP
	DCR C
	JNZ OUTLOOP
	RET
RST 5