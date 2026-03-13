; 问题: 编程，将data段中的数据以十进制的形式显示出来。
; 名称：dtoc
; 功能：将word型数据转变为表示十进制数的字符串，字符串以0为结尾符。
; 参数：
; (ax)=word型数据
; ds:si指向字符串的首地址
; 返回：无
; 应用举例：编程，将数据12666 以十进制的形式在屏幕的8行3列，用绿色显示出来。在显示时我们调用本次实验中的第一个子程序show_str。
; 十进制数码字符对应的ASCII码= 十进制数码值+30H。


ASSUME CS:CODE,DS:DATASG,SS:STACKSG
DATASG SEGMENT
         DB 10 DUP(0)
DATASG ENDS

STACKSG SEGMENT
          DW 16 DUP(0)
STACKSG ENDS

CODE SEGMENT

  DTOC:    MOV  BX,10
           MOV  DX,0
           DIV  BX
           ADD  DL,30H
           MOV  DS:[SI],DL
           MOV  DX,0
           MOV  CX,AX
           JCXZ DTOC_OK
           INC  SI
           JMP  DTOC
  DTOC_OK: MOV  AX,0
           MOV  DS:[SI+1],AL
           RET
           
  SHOW_STR:MOV  AX,0B800H
           MOV  ES,AX

           MOV  AH,160
           MOV  AL,DH
           MUL  AH
           MOV  BX,AX

           MOV  AX,2
           MUL  DL
           MOV  DI,AX

           MOV  AL,CL
           MOV  AH,0
           MOV  CX,0
  SHOW_L:  MOV  CL,DS:[SI]
           MOV  ES:[BX][DI],CL
           MOV  ES:[BX][DI+1],AL
           INC  SI
           ADD  DI,2
           JCXZ SHOW_OK
           JMP  SHOW_L
  SHOW_OK: RET

  START:   MOV  AX,STACKSG
           MOV  SS,AX
           MOV  SP,20H
           MOV  AX,DATASG
           MOV  DS,AX
           MOV  SI,0

           MOV  AX,12666
           CALL DTOC

           MOV  SI,0
           MOV  DH,8
           MOV  DL,3
           MOV  CL,2
           CALL SHOW_STR

           MOV  AX,4C00H
           INT  21H

CODE ENDS
END START