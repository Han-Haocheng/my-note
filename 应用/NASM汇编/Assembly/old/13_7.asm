; 在屏幕的5行12列显示字符串“Welcome to masm!”

ASSUME CS:CODE,DS:DATA
DATA SEGMENT
       DB 'Welcome to masm!$'
DATA ENDS
CODE SEGMENT
  START:MOV AH,2
        MOV BX,0
        MOV DX,050CH
        INT 10H

        MOV AX,DATA
        MOV DS,AX
        MOV DX,0
        MOV AX,0900H
        INT 21H
        
        MOV AX,4C00H
        INT 21H
CODE ENDS
END START