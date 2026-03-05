; 编写并安装int 7ch 中断例程，功能为完成loop指令的功能。
; 分别在屏幕的第2、4、6、8行显示4句英文诗，补全程序。

ASSUME CS:CODE
CODE SEGMENT
	S1:   DB   'Good,better,best,','$'
	S2:   DB   'Never let it rest,','$'
	S3:   DB   'Till good is better,','$'
	S4:   DB   'And better,best.','$'
	S:    DW   OFFSET S1,OFFSET S2,OFFSET S3,OFFSET S4
	ROW:  DB   2,4,6,8

	START:MOV  AX,CS
	      MOV  DS,AX
	      MOV  BX,OFFSET S
	      MOV  SI,OFFSET ROW
	      
	      MOV  CX,4
	OK:   MOV  BH,0
	      MOV  DH,DS:[SI]
	      MOV  DL,0
	      MOV  AH,2
	      INT  10H
				
	      MOV  DX,[BX]
	      MOV  AH,9
	      INT  21H

	      INC  SI
	      ADD  BX,2
	      LOOP OK

	      MOV  AX,4C00H
	      INT  21H
CODE ENDS
END START