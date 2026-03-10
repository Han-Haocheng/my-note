; 编程，用串传送指令，将F000H段中的最后16个字符复制到data段中。

ASSUME CS:CODE,DS:DATA
DATA SEGMENT
            DB 16 DUP(0)
DATA ENDS
CODE SEGMENT
       START:MOV AX,0F000H
             MOV DS,AX
             MOV SI,0FFFFH

             MOV AX,DATA
             MOV ES,AX
             MOV DI,0FH
             MOV CX,10H
             STD
             REP MOVSB

             MOV AX,4C00H
             INT 21H

CODE ENDS
END START