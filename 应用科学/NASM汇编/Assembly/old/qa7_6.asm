;将DATASG 段中每个单词的头一个字母改为大写字母
ASSUME CS:CODESG,DS:DATASG

DATASG SEGMENT
	DB	'1. file         '
	DB	'2. edit         '
	DB	'3. search       '
	DB	'4. view         '
	DB	'5. options      '
	DB	'6. help         '
DATASG ENDS

CODESG SEGMENT
START:
	MOV AX,DATASG
	MOV DS,AX

	MOV BX,0
	MOV CX,6
S:	
	MOV AX,[3+BX]
	AND	AX,11011111B
	MOV [3+BX],AL
	ADD	BX,16
	LOOP	S

	MOV AX,4C00H
	INT 21H
CODESG ENDS

END START