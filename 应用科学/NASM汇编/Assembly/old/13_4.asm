ASSUME CS:CODE,DS:DATA
DATA SEGMENT
	     DB 'conversation',0
DATA ENDS
CODE SEGMENT
	START:  MOV  AX,CS
	        MOV  DS,AX
	        MOV  SI,OFFSET CAPITAL

	        MOV  AX,0
	        MOV  ES,AX
	        MOV  DI,200H

	        MOV  CX,OFFSET CPL_ED - OFFSET CAPITAL
	        CLD
	        REP  MOVSB

	        MOV  WORD PTR ES:[4*7CH],200H
	        MOV  WORD PTR ES:[4*7CH+2],0
	
	MAIN:   MOV  AX,DATA
	        MOV  DS,AX
	        MOV  SI,0
	        INT  7CH

	        MOV  AX,4C00H
	        INT  21H

	CAPITAL:PUSH SI
	        PUSH CX
	L:      MOV  CL,DS:[SI]
	        MOV  CH,0
	        AND  BYTE PTR DS:[SI],11011111B
	        JCXZ OK
	        INC  SI
	        JMP  SHORT  L
	OK:     POP  CX
	        POP  SI
	        IRET
	CPL_ED: NOP
CODE ENDS
END START