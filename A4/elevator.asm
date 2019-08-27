cpu "8085.tbl"
hof "int8"

org	9000H

GTHEX: EQU 030EH
OUTPUT: EQU 0389H
HXDSP: EQU 034FH
RDKBD: EQU 03BAH
CLEAR: EQU 02BEH

LDA 8200H  ;loading boss's location
MOV H,A	   ;storing boss's location in H			
MVI A, 8BH	;setting control word to make portA o/p, portB and poartC i/p		
OUT 43H

;B stores the direction
;B=01 when going up and B=00 when going down

;checking conditions for floor0
FLOOR0:
	MVI B,01H		;setting direction as going up
	MVI A, 00H		
	STA 8202H		;storing current elevator location
	OUT 40H			;displaying current elevator location
	CALL DELAY
	IN 41H 			;checking if there is any other request
	CPI 00H 
	JZ FLOOR0  		;looping if no other request
	IN 41H			
	ANA H			
	CMP H			;comparing if current level is the boss level
	JZ BOSS			;jumping to boss routine
	IN 41H
    MOV A,B
	CPI 00H			
	JZ FLOOR0		
	JMP FLOOR1		
FLOOR1:		
	MVI A, 01H		
	STA 8202H		;storing current elevator location
	OUT 40H			;displaying current elevator location
	CALL DELAY
	IN 41H
	ANI 01H			;checking if dip1 is still on
	CPI 01H
	JZ FLOOR1		;looping
	IN 41H
	ANA H
	CMP H			;comparing if current level is the boss level
	JZ BOSS			;jumping to boss routine
	MOV A,B			
	CPI 00H			;checking the current direction
	JZ FLOOR0		;if 00H the going to a lower floor
	IN 41H
	ANI 0FFH
	CPI 01H			;checking if only current floor is requested
	MVI B,00H		;changing the direction
	JC FLOOR0		;jumping to lower floor
	JZ FLOOR1		;otherwise staying on the current floor
	MVI B,01H		;setting the direction to up
	JMP FLOOR2 		;going to upper floor

;all the following floors work similar to floor1
FLOOR2:		
	MVI A, 02H
	STA 8202H
	OUT 40H
	CALL DELAY
	IN 41H
	ANI 02H
	CPI 02H
	JZ FLOOR2
	IN 41H
	ANA H
	CMP H
	JZ BOSS
	MOV A,B
	CPI 00H
	JZ FLOOR1
	IN 41H
	ANI 0FEH
	CPI 02H
	MVI B,00H
	JC FLOOR1
	JZ FLOOR2
	MVI B,01H
	JMP FLOOR3
FLOOR3:
	MVI A, 04H
	STA 8202H
	OUT 40H
	CALL DELAY
	IN 41H
	ANI 04H
	CPI 04H
	JZ FLOOR3
	IN 41H
	ANA H
	CMP H
	JZ BOSS
	MOV A,B
	CPI 00H
	JZ FLOOR2
	IN 41H
	ANI 0FCH
	CPI 04H
	MVI B,00H
	JC FLOOR2
	JZ FLOOR3
	MVI B,01H
	JMP FLOOR4
FLOOR4:
	MVI A, 08H
	STA 8202H
	OUT 40H
	CALL DELAY
	IN 41H
	ANI 08H
	CPI 08H
	JZ FLOOR4
	IN 41H
	ANA H
	CMP H
	JZ BOSS
	MOV A,B
	CPI 00H
	JZ FLOOR3
	IN 41H
	ANI 0F8H
	CPI 08H
	MVI B,00H
	JC FLOOR3
	JZ FLOOR4
	MVI B,01H
	JMP FLOOR5
FLOOR5:
	MVI A, 10H
	STA 8202H
	OUT 40H
	CALL DELAY
	IN 41H
	ANI 10H
	CPI 10H
	JZ FLOOR5
	IN 41H
	ANA H
	CMP H
	JZ BOSS
	MOV A,B
	CPI 00H
	JZ FLOOR4
	IN 41H
	ANI 0F0H
	CPI 10H
	MVI B,00H
	JC FLOOR4
	JZ FLOOR5
	MVI B,01H
	JMP FLOOR6
FLOOR6:
	MVI A, 20H
	STA 8202H
	OUT 40H
	CALL DELAY
	IN 41H
	ANI 20H
	CPI 20H
	JZ FLOOR6
	IN 41H
	ANA H
	CMP H
	JZ BOSS
	MOV A,B
	CPI 00H
	JZ FLOOR5
	IN 41H
	ANI 0E0H
	CPI 20H
	MVI B,00H
	JC FLOOR5
	JZ FLOOR6
	MVI B,01H
	JMP FLOOR7
FLOOR7: 
	MVI A, 40H
	STA 8202H
	OUT 40H
	CALL DELAY
	IN 41H
	ANI 40H
	CPI 40H
	JZ FLOOR7
	IN 41H
	ANA H
	CMP H
	JZ BOSS
	MOV A,B
	CPI 00H
	JZ FLOOR6
	IN 41H
	ANI 0C0H
	CPI 40H
	MVI B,00H
	JC FLOOR6
	JZ FLOOR7
	MVI B,01H
	MVI B,01H
	JMP FLOOR8
FLOOR8:	
	MVI B, 00H
	MVI A, 80H
	STA 8202H
	OUT 40H
	CALL DELAY
	IN 41H
	ANI 80H
	CPI 80H
	JZ FLOOR8
	IN 41H
	ANA H
	CMP H
	JZ BOSS
	IN 41H
	ANI 080H
	CPI 80H
	JC FLOOR7
	JZ FLOOR8

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

;boss routine
BOSS:				
	LDA 8202H		
	CMP H			;Compares BOSS floor with current floor(8202H memory location)
	JC HIGHBOSS		;If boss floor is higher than present location, goes to HIGHBOSS subroutine
	JZ WAIT			;If boss is at same floor jumps to WAIT subroutine
	JMP LOWBOSS		;If boss floor is lower than present floror, jumps to LOWBOSS subroutine
HIGHBOSS:
	LDA 8202H		;changes elevator position to boss position(incrementing) A, then jumps to WAIT
	CPI 00H
	JZ INCREMENT	;ensures A has a 1 bit somewhere in its 8 bits (highboss can be called from floor0 as well)	
	RLC				;logical left circular shift
	STA 8202H
RETURN:	OUT 40H
	CALL DELAY
	LDA 8202H
	CMP H
	JC HIGHBOSS
	JZ WAIT
;changes elevator position to boss position(decrementing) A, then jumps to WAIT
LOWBOSS:			
	LDA 8202H
	RRC
	STA 8202H
	OUT 40H
	CALL DELAY
	LDA 8202H
	CMP H
	JZ WAIT
	JMP LOWBOSS 	
;waits for boss floor request to go low, then goes to TOZERO subroutine
WAIT:				
	IN 41H
	ANA H
	CMP H	
	JZ WAIT
	CALL DELAY
;Takes elevator with boss in it to ground floor (floor0)
TOZERO:				
	LDA 8202H
	RRC			
	STA 8202H
	OUT 40H
	CALL DELAY
	LDA 8202H
	CPI 01H
	JZ FLOOR0	;Jumps to floor0 subroutine after boss reaches floor0	
	JMP TOZERO
INCREMENT:			
	ADI 01H
	STA 8202H
	JMP RETURN