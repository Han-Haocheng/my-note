; (DH)=行号(取值范围0~24),
; (DL)=列号(取值范围0~79),
; (CL)=颜色，
; DS:SI指向字符串的首地址

ASSUME CS:CODE

DATA SEGMENT
	     DB 'WELCOME TO MASM!',0
DATA ENDS

STACK SEGMENT
	      DW 8 DUP(0)
STACK ENDS

CODE SEGMENT
	START:   

	         MOV  AX,DATA
	         MOV  DS,AX
	         MOV  SI,0

	         MOV  DH,8
	         MOV  DL,10
	         MOV  CL,2
	         CALL SHOW_STR
	
	         MOV  AX,4C00H
	         INT  21H

	; AX,BX,CX,DX,ES,SI,DI
	SHOW_STR:MOV  AX,0B800H
	         MOV  ES,AX

	         MOV  AH,160
	         MOV  AL,DH
	         MUL  AH
	         MOV  BX,AX

	         MOV  AX,2
	         MUL  DL
	         MOV  DI,AX

	         MOV  AL,CL
	         MOV  AH,0
	         MOV  CX,0
	CHANGE:  MOV  CL,DS:[SI]
	         MOV  ES:[BX][DI],CL
	         MOV  ES:[BX][DI+1],AL
	         INC  SI
	         ADD  DI,2
	         JCXZ OK
	         JMP  CHANGE
	OK:      RET

	
CODE ENDS
END START