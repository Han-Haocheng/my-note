; 编写并安装int 7ch 中断例程，功能为完成loop指令的功能。

ASSUME CS:CODE
CODE SEGMENT
  START:MOV  AX,CS
        MOV  DS,AX
        MOV  SI,OFFSET LP
              
        MOV  AX,0
        MOV  ES,AX
        MOV  DI,0200H

        MOV  CX,OFFSET LPE-OFFSET LP
        CLD
        REP  MOVSB

        MOV  WORD PTR ES:[4*7CH],0200H
        MOV  WORD PTR ES:[4*7CH+2],0
        
        MOV  AX,0B800H
        MOV  ES,AX
        MOV  DI,160*12
        MOV  BX,OFFSET S-OFFSET SE      ;设置从标号SE到标号S的转移位移
        MOV  CX,80

  S:    MOV  BYTE PTR ES:[DI],'!'
        ADD  DI,2
        INT  7CH                        ;如果(CX)≠0,转移到标号S处
  SE:   NOP
        
        MOV  AX,4C00H
        INT  21H

  LP:   PUSH BP
        MOV  BP,SP
        DEC  CX
        JCXZ CTN
        ADD  [BP+2],BX
  CTN:  POP  BP
        IRET
  LPE:  NOP
CODE ENDS
END START

