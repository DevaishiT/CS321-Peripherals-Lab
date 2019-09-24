cpu "8085.tbl"
hof "int8"
org 9000h

MVI A,8BH                
OUT 43H

MVI A,80H
OUT 03H


MVI A,88H
LOOP:
PUSH PSW                 
OUT 00H
MVI D,00H                
MVI E,00H
CALL CONVERT            
STA 8501H
MOV B,A 			
MVI A,0FFH				
SUB B
MOV C,A
STA 8500H				 
CALL DELAY

MVI D,00H
MVI E,00H   			 
MVI A,32H
MVI C,04H
STA 8500H
LDA 8501H				 

CALL DISPLAY             
POP PSW
RRC						 
JMP LOOP


DELAY:                   
	LOOP4a:  MVI D,01H
	LOOP1a: LDA 8500H  
	MOV E, A
	LOOP2a:  DCR E
	    JNZ LOOP2a
	    DCR D
	    JNZ LOOP1a
	    DCR C
	    JNZ LOOP4a
RET



CONVERT:                
	MVI A,00H 			
	ORA D 				
	OUT 40H

	MVI A,20H			
	ORA D 				
	OUT 40H
	
	NOP
	NOP

	MVI A,00H      		
	ORA D
	OUT 40H


WAIT1:	
	IN 42H				
	ANI 01H
	JNZ WAIT1 			
WAIT2:
	IN 42H				
	ANI 01H
	JZ WAIT2			

	MVI A,40H
	ORA D
	OUT 40H
	NOP

	IN 41H				

	PUSH PSW			

	MVI A,00H 			
	ORA D
	OUT 40H
	POP PSW

RET

DISPLAY:
		call DELAY 		
		LDA 8501H
		PUSH PSW		


DISPKBD:
		MOV A,E 		
		STA 8FEFH
		XRA A 			
		STA 8FF0H
		POP PSW			
		STA 8FF1H
		PUSH D 			
		MVI B,00H
		CALL 0440H 		
		MVI B,00H
		CALL 0440H 		
		MVI B,00
		CALL 044CH 		
		POP D
		RET