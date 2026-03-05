ASSUME CS:CODE,DS:DATA,SS:STACK
STACK SEGMENT
	      DB 128 DUP(0)
STACK ENDS

DATA SEGMENT
	S    DB '0123456789ABCDEF'
DATA ENDS

CODE SEGMENT
	START:MOV AX,STACK
	      MOV SS,AX
	      MOV SP,128
				
	      MOV AX,DATA
	      MOV DS,AX

	      MOV AX,0B800H
	      MOV ES,AX

	      MOV AL,9AH

	      MOV AH,AL
	      SHR AH,1
	      SHR AH,1
	      SHR AH,1
	      SHR AH,1
	      AND AL,00001111B

	      MOV BL,AH
	      MOV BH,0
	      MOV AH,S[BX]
				
	      MOV ES:[160*13+15*2],AH

	      MOV BL,AL
	      MOV BH,0
	      MOV AL,S[BX]
	      MOV ES:[160*13+15*2+2],AL

	      MOV AX,4C00H
	      INT 21H


CODE ENDS
END START
