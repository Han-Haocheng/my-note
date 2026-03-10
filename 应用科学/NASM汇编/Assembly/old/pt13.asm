ASSUME CS:CODE
DATA SEGMENT
       DB 'conversation',0
DATA ENDS
CODE SEGMENT
  START:MOV  AX,CS
        MOV  DS,AX
        MOV  SI,OFFSET JNR

        MOV  AX,0
        MOV  ES,AX
        MOV  DI,200H

        MOV  CX,OFFSET JNRE - OFFSET JNR
        CLD
        REP  MOVSB

        MOV  WORD PTR ES:[4*7CH],200H
        MOV  WORD PTR ES:[4*7CH+2],0
        MOV  AX,DATA
        MOV  DS,AX
        MOV  SI,0
        MOV  AX,0B800H
        MOV  ES,AX
        MOV  DI,12*160

  S:    CMP  BYTE PTR[SI],0
        JE   OK                           ;如果是0跳出循环
        MOV  AL,[SI]
        MOV  ES:[DI],AL
        INC  SI
        ADD  DI,2
        MOV  BX,OFFSET S-OFFSET OK        ;设置从标号OK到标号S的转移位移
        INT  7CH                          ;转移到标号S处
  OK:   MOV  AX,4C00H
        INT  21H
        
  ; 参数：bx 位移
  JNR:  PUSH BP
        MOV  BP,SP
        ADD  [BP+2],BX
        POP  BP
        IRET
  JNRE: NOP
CODE ENDS
END START