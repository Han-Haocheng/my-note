assume cs:codesg,ds:datasg

datasg segment
	db	'welcome to masm!'
	db	'................'
datasg ends

CODESG SEGMENT
START:
	MOV AX,DATASG
	MOV DS,AX
	MOV SI,00H

	MOV	CX,8H
S:	
	MOV	AX,[0+SI]
	MOV [10H+SI],AX
	ADD SI,2
	LOOP	S

	MOV AX,4C00H
	INT 21H
CODESG ENDS

END START