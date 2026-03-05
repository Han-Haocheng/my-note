ASSUME CS:CODE,DS:DATA,SS:STACK
STACK SEGMENT
	      DW 128 DUP(0)
STACK ENDS

DATA SEGMENT
	     DW 0,0
DATA ENDS

CODE SEGMENT
	; 安装9号例程,这个不用进行分离
	START:  MOV   AX,STACK
	        MOV   SS,AX
	        MOV   SP,256

	        MOV   AX,DATA
	        MOV   DS,AX

	        MOV   AX,0
	        MOV   ES,AX

	        PUSH  ES:[9*4]
	        POP   DS:[0]
	        PUSH  ES:[9*4+2]
	        POP   DS:[2]
	        
	        STI
	        MOV   WORD PTR ES:[9*4],OFFSET RT9
	        MOV   ES:[9*4+2],CS
	        CLI

	;  显示a-z
	        MOV   AX,0B800H
	        MOV   ES,AX

	        MOV   AH,00011010B
	        MOV   AL,'a'
	WTSTR:  MOV   ES:[12*160+20*2],AX
	        CALL  DLY
	        INC   AL
	        CMP   AL,'z'
	        JNA   WTSTR

	        MOV   AX,4C00H
	        INT   21H

	DLY:    PUSH  AX
	        PUSH  DX

	        MOV   DX,100H
	        MOV   AX,0
	S1:     SUB   AX,1
	        SBB   DX,0
	        CMP   AX,0
	        JNE   S1
	        CMP   DX,0
	        JNE   S1
	      
	        POP   DX
	        POP   AX
	        RET
	DLYE:   NOP
	
	; 9号例程
	RT9:    PUSH  AX
	        PUSH  BX
	        PUSH  ES
	        IN    AL,60H

	        PUSHF
	        PUSHF
	        POP   BX
	        AND   BH,11111100B
	        PUSH  BX
	        POPF
	        CALL  DWORD PTR DS:[0]            	;对INT指令进行模拟，调用原来的INT 9中断例程
	        
	        CMP   AL,1
	        JNE   INT9RET
	        MOV   AX,0B800H
	        MOV   ES,AX
	        INC   BYTE PTR ES:[12*160+20*2+1] 	;将属性值加1,改变颜色
	INT9RET:POP   ES
	        POP   BX
	        POP   AX
	        IRET
CODE ENDS
END START
