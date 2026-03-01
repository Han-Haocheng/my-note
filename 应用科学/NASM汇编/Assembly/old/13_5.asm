; 问题：用7ch中断例程完成loop 指令的功能。
; loop s 的执行需要两个信息，循环次数和到s的位移，所以，7ch 中断例程要完成loop指令的功能，也需要这两个信息作为参数。
; 我们用cx存放循环次数，用bx存放位移。
; 应用举例：在屏幕中间显示80个‘!’。

ASSUME CS:CODE
CODE SEGMENT
  START:MOV  AX,CS
        MOV  DS,AX
        MOV  SI,OFFSET LOP
        
        MOV  AX,0
        MOV  ES,AX
        MOV  DI,0200H

        MOV  CX,OFFSET LOPE - OFFSET LOP
        CLD
        REP  MOVSB

        MOV  WORD PTR ES:[4*7CH],0200H
        MOV  WORD PTR ES:[4*7CH+2],0
  
        MOV  AX,0B800H
        MOV  ES,AX
        MOV  DI,160*12
        MOV  BX,OFFSET S-OFFSET SE
        MOV  CX,80
  
  S:    MOV  BYTE PTR ES:[DI],'!'
        ADD  DI,2
        INT  7CH
  SE:   NOP

        MOV  AX,4C00H
        INT  21H

  LOP:  PUSH BP
        MOV  BP,SP
        DEC  CX
        JCXZ OK
        ADD  [BP+2],BX
  OK:   POP BP
        IRET
  LOPE: NOP

CODE ENDS
END START