; 在屏幕中间显示当前的月份

ASSUME CS:CODE
CODE SEGMENT
	START:MOV AL,8
	      OUT 70H,AL
	      IN  AL,71H
	      MOV AH,AL
	      MOV CL,4
	      SHR AH,CL
	      AND AL,00001111B
	      ADD AH,30H
	      ADD AL,30H
	      MOV BX,0B800H
	      MOV ES,BX
	      MOV BYTE PTR ES:[160*12+40*2],AH
	      MOV BYTE PTR ES:[160*12+40*2+2],AL

	      MOV AX,4C00H
	      INT 21H
CODE ENDS
END START