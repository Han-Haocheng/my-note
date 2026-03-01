; 编写并安装INT 7CH 中断例程,功能为显示一个用0结束的字符串,中断例程安装在0:200处
; 参数：(DH)=行号，(DI)=列号，(CL)=颜色，DS:SI指向字符串首地址。


ASSUME CS:CODE,DS:DATA

DATA SEGMENT
       DB "welcome to masm!",0
DATA ENDS

CODE SEGMENT
  START:MOV  AX,CS
        MOV  DS,AX
        MOV  SI,OFFSET SW_S
              
        MOV  AX,0
        MOV  ES,AX
        MOV  DI,0200H

        MOV  CX,OFFSET SW_SE-OFFSET SW_S
        CLD
        REP  MOVSB

        MOV  WORD PTR ES:[4*7CH],0200H
        MOV  WORD PTR ES:[4*7CH+2],0
        
        
        MOV  DH,10
        MOV  DL,10
        MOV  CL,2
        MOV  AX,DATA
        MOV  DS,AX
        MOV  SI,0
        INT  7CH

        MOV  AX,4C00H
        INT  21H

  ; 参数：(DH)=行号，(DL)=列号，(CL)=颜色，DS:SI指向字符串首地址

  SW_S: PUSH SI
        PUSH DI
        PUSH AX
        PUSH CX

        MOV  AL,DH
        MOV  AH,0A0H
        MUL  AH
        MOV  DI,AX

        MOV  AL,DL
        MOV  AH,2
        MUL  AH
        ADD  DI,AX

        MOV  AX,0B800H
        MOV  ES,AX

        MOV  AL,CL
        MOV  CH,0
  CPY:  MOV  CL,DS:[SI]
        MOV  AL,CL
        MOV  ES:[DI],AX
        INC  DI
        INC  DI
        INC  SI
        JCXZ CPYOK
        JMP  CPY
              
  CPYOK:POP  CX
        POP  AX
        POP  DI
        POP  SI
        IRET
  SW_SE:NOP

CODE ENDS
END START