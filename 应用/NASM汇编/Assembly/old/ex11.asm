; 实验11 编写子程序
; 编写一个子程序，将包含任意字符，以0结尾的字符串中的小写字母转变成大写字
; 母，描述如下。
; 名称：letterc
; 功能：将以0结尾的字符串中的小写字母转变成大写字母
; 参数：ds:si指向字符串首地址
; 应用举例：
ASSURNE CS:CODESG
DATASG SEGMENT
         DB "Beginner's All-purpose Symbolic Instruction Code.",0
DATASG ENDS

CODESG SEGMENT
  BEGIN:  MOV   AX, DATASG
          MOV   DS,AX
          MOV   SI,0
          CALL  LETTERC
          
          MOV   AX,4C00H
          INT   21H

  LETTERC:PUSH  SI
          PUSH  CX
          PUSHF

          MOV   CX,0
  BEGIN:  MOV   CL,DS:[SI]
          JCXZ  OK
          CMP   CL,'z'
          JA    CTN
          CMP   CL,'a'
          JB    CTN
          AND   CL,11011111B
          MOV   DS:[SI],CL
  CTN:    INC   SI
          JMP   SHORT BEGIN
          
  OK:     POPF
          POP   CX
          POP   SI
          RET


CODESG ENDS
END BEGIN

; 注意需要进行转化的是字符串中的小写字母a~z,而不是其他字符。
