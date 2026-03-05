; 任务：安装一个新的int 9中断例程。
; 功能：在DOS下，按F1键后改变当前屏幕的显示颜色，其他的键照常处理。

ASSUME CS:CODE,SS:STACK
STACK SEGMENT
	      DB 128 DUP(0)
STACK ENDS


CODE SEGMENT
	START:MOV   AX,STACK
	      MOV   SS,AX
	      MOV   SP,128

	      PUSH  CS
	      POP   DS
	      MOV   SI,OFFSET IT9

	      MOV   AX,0
	      MOV   ES,AX
	      MOV   DI,0204H

	      MOV   CX,OFFSET IT9E-OFFSET IT9
	      CLD
	      REP   MOVSB

	      PUSH  ES:[4*09H]
	      POP   ES:[200H]
	      PUSH  ES:[4*09H+2]
	      POP   ES:[202H]

	      STI
	      MOV   WORD PTR ES:[4*09H],0200H
	      MOV   WORD PTR ES:[4*09H+2],0
	      STI

	      MOV   AX,4C00H
	      INT   21H

	IT9:  PUSH  AX
	      PUSH  BX
	      PUSH  CX
	      PUSH  DS

	      IN    AL,60H
				
	      PUSHF
	      CALL  DWORD PTR CS:[200H]

	      CMP   AL,3BH
	      JNE   IT9RT

	      MOV   AX,0B800H
	      MOV   DS,AX
	      MOV   BX,1
	      MOV   CX,2000

	S:    INC   BYTE PTR   DS:[BX]
	      ADD   BX,2
	      LOOP  S

	IT9RT:POP   DS
	      POP   CX
	      POP   BX
	      POP   AX
	      IRET
	IT9E: NOP

CODE ENDS
END START