ASSUME CS:CODE,SS:STACK
STACK SEGMENT
	      DB 128 DUP(0)
STACK ENDS


CODE SEGMENT
	START:     MOV  AX,STACK
	           MOV  SS,AX
	           MOV  SP,128

	           MOV  AH,2
	           MOV  AL,7
	           CALL SETSCREEN
	           MOV  AX,4C00H
	           INT  21H

	SETSCREEN: JMP  SHORT SET
	           DW   CLS,STAF,STBK,RLL1
	SET:       PUSH BX
	           CMP  AH,3
	           JA   SETE
	           MOV  BL,AH
	           MOV  BH,0
	           ADD  BX,BX

	           CALL WORD PTR TABLE[BX]
	SETE:      NOP

	; 参数 无
	CLS:       PUSH BX
	           PUSH ES
	           PUSH CX
					
	           MOV  BX,0B800H
	           MOV  ES,BX
	           MOV  BX,0
	           MOV  CX,2000

	CLSL:      MOV  BYTE PTR  ES:[BX],' '
	           ADD  BX,2
	           LOOP CLSL

	           POP  CX
	           POP  ES
	           POP  BX
	           RET
	CLSE:      NOP

	; 参数 AL
	STAF:      PUSH AX
	           PUSH BX
	           PUSH ES
	           PUSH CX


	           MOV  BX,0B800H
	           MOV  ES,BX
	           MOV  BX,0
	           MOV  CX,2000
		
	STAFL:     AND  BYTE PTR  ES:[BX+1],11110000B
	           OR   BYTE PTR  ES:[BX+1],AL
	           ADD  BX,2
	           LOOP STAFL

	           POP  CX
	           POP  ES
	           POP  BX
	           POP  AX
	           RET
	STAFE:     NOP

	; 参数 aH
	STBK:      PUSH AX
	           PUSH BX
	           PUSH ES
	           PUSH CX

	           MOV  CL,4
	           SHL  AL,CL

	           MOV  BX,0B800H
	           MOV  ES,BX
	           MOV  BX,0
	           MOV  CX,2000
	STBKL:     AND  BYTE PTR  ES:[BX+1],00001111B
	           OR   BYTE PTR  ES:[BX+1],AL
	           ADD  BX,2
	           LOOP STBKL

	           POP  CX
	           POP  ES
	           POP  BX
	           POP  AX
	           RET
	STBKE:     NOP
		
	; 参数 无
	RLL1:      PUSH BX
	           PUSH DS
	           PUSH ES
	           PUSH SI
	           PUSH DI
	           PUSH CX

	           MOV  BX,0B800H
	           MOV  DS,BX
	           MOV  ES,BX
	           MOV  SI,160
	           MOV  DI,0

	           MOV  CX,2000
	           CLD
	           REP  MOVSW

	           POP  CX
	           POP  DI
	           POP  SI
	           POP  ES
	           POP  DS
	           POP  BX
	           RET
	RLL1E:     NOP
	SETSCREENE:NOP
CODE ENDS
END START
