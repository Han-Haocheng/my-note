ASSUME CS:CODE,DS:DATA,SS:STACK
STACK SEGMENT
	      DB 128 DUP(0)
STACK ENDS

DATA SEGMENT
	TABLE DW AG0,AG30,AG60,AG90,AG120,AG150,AG180
	AG0   DB '0',0                               	;SIN(0)对应的字符串“0”
	AG30  DB '0.5',0                             	;SIN(30)对应的字符串“0.5”
	AG60  DB '0.866',0                           	;SIN(60)对应的字符串“0.866”
	AG90  DB '1',0                               	;SIN(90)对应的字符串“1”
	AG120 DB '0.866',0                           	;SIN(120)对应的字符串“0.866”
	AG150 DB '0.5',0                             	;SIN(150)对应的字符串“0.5”
	AG180 DB '0',0                               	;sin(180)对应的字符串“0”
DATA ENDS

CODE SEGMENT
	START:

	      MOV BX,0B800H
	      MOV ES,BX
	      MOV DI,160*12+40*2
				
	      MOV BX,DATA
	      MOV DS,BX
				
	      MOV AX,30
	      MOV BL,30
	      DIV BL

	      MOV BL,AL
	      MOV BH,0
	      ADD BX,BX
	      MOV BX,TABLE[BX]

	S:    MOV AH,DS:[BX]
	      CMP AH,0
	      JE  OK
	      MOV ES:[DI],AH
	      INC BX
	      ADD DI,2
	      JMP SHORT S

	OK:   

	      MOV AX,4C00H
	      INT 21H

CODE ENDS
END START
