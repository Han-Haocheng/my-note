ASSUME CS:CODE,DS:DATA
DATA SEGMENT
       
DATA ENDS
STACK SEGMENT
        DW 16 DUP(0)
STACK ENDS
CODE SEGMENT
  ;DO0安装程序
  START:MOV  AX, STACK
        MOV  SS,AX
        MOV  SP,16*2
        
        MOV  AX,CS
        MOV  DS,AX
        MOV  SI,OFFSET DO0

        MOV  AX,0
        MOV  ES,AX
        MOV  DI,200H
  
  ;“-”是编译器识别的运算符号，编译器可以用它来进行两个常数的减法。
        MOV  CX,OFFSET DO0ED-OFFSET DO0
        CLD
        REP  MOVSB
  
  ;设置中断向量表
        MOV  AX,0
        MOV  ES,AX
        MOV  WORD PTR ES:[0],200H
        MOV  WORD PTR ES:[2],0
        
        MOV  AX,4C00H
        INT  21H

  ;显示字符串"OVERFLOW!"
  DO0:  JMP  SHORT DO0BG
        DB   "OVERFLOW!"

  DO0BG:MOV  AX,CS
        MOV  DS,AX
        MOV  SI,202H

        MOV  AX,0B800H
        MOV  ES,AX
        MOV  DI,12*160+36*2
        MOV  AH,111B

        MOV  CX,9
  S:    MOV  AL,[SI]
        MOV  ES:[DI],AL
        MOV  ES:[DI+1],AH
        INC  SI
        ADD  DI,2
        LOOP S

        MOV  AX,4C00H
        INT  21H
  DO0ED:NOP
CODE ENDS
END START