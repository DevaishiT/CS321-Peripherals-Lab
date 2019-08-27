cpu "8085.tbl"
hof "int8"

GTHEX: EQU 030EH
OUTPUT: EQU 0389H
HXDSP: EQU 034FH
RDKBD: EQU 03BAH
CLEAR: EQU 02BEH

org 9000h

;to check if dip 6 is on we compare with 04H
;to check if dip 8 is on we compare with 01H
;to check if dip 2 is on we compare with 40H

MVI A, 8BH ;setting control word for configuring
OUT 43H    ;8255 in mode0, portA o/p, portB i/p, portC i/p
MVI B, 01H

START:
    IN 41H  ;taking input from portB
    ANI 04H ;checking dip6
    CPI 04H
    JZ CONTINUE ;continuing if dip6 is on
    IN 41H ;taking input from portB
    ANI 40H ;checking dip2
    CPI 40H
    JZ EXIT ;exiting if dip2 is on
    JMP START ;loop on start

CONTINUE:
    IN 41H ;taking input from portB
    ANI 40H
    CPI 40H
    JZ EXIT ;exiting if dip2 is on
    IN 41H ;taking input from portB
	MOV D,A
	ANI 001H ;checking dip5
	CPI 01H
	JZ CONTINUE ;pausing if dip5 is on
	MOV A,D
	ANI 004H ;checking dip6
	CPI 04H
	JNZ CONTINUE
    MOV A,B
    OUT 40H ;diplaying the ouput on portA
    RLC ;rotating contents of B to the left cyclically
    MOV B,A
    CALL DELAY ;calling delay to delay by 1 sec
    JMP CONTINUE ;looping over this label

EXIT:
    RST 5

DELAY:
	MVI C,03H
OUTLOOP:
	LXI D,0AF00H
INLOOP:
	DCX D		
	MOV A,D
	ORA E		
	JNZ INLOOP
	DCR C
	JNZ OUTLOOP
	RET
