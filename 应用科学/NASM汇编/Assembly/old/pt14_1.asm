ASSUME CS:CODE
CODE SEGMENT
  SRT1:MOV AL,02H
        OUT 70H,AL
        IN  AL,71H

        MOV AL,02H
        OUT 70H,AL
        MOV AL,0H
        OUT 71H,AL  

        MOV AX,4C00H
        INT 21H
        ; 编程，用加法和移位指令计算(ax)=(ax)*10.
        ; 提示，(ax)*10=(ax)*2+(ax)*8。
  SRT2: MOV AX,123H
        SHL AX,1
        MOV DX,AX
        SHL AX,1
        SHL AX,1
        ADD AX,DX
CODE ENDS
END SRT2