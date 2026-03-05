ASSUME CS:CODE

CODE SEGMENT
  START:MOV  AX,CS
        MOV  DS,AX
        MOV  SI,OFFSET SQR

        MOV  AX,0
        MOV  ES,AX
        MOV  DI,200H

        MOV  CX,OFFSET SQRED-OFFSET SQR
        CLD
        REP  MOVSB

        MOV WORD PTR ES:[4*7CH],200H
        MOV WORD PTR ES:[4*7CH+2],0

        MOV  AX,4C00H
        INT  21H
        
  SQR:  MUL  AX
        IRET
  SQRED:NOP
CODE ENDS
END START