; 编程：在屏幕中间分别显示绿色、绿底红色、白底蓝色的字符串'welcome to masm!'。

; 属性：背景色、前景色、闪烁、高亮等组合信息
; 地址空间:B8000H-BFFFFH = 32KB
; 显示缓存：80x25像素共8页
; 单像素：2Byte 高属性+低字符
; 第0页: B8000H-B8F9FH
; 	01行：000~09F
; 	02行：0A0~13F
; 	03行：140~1BF
; 	04行：1C0
;   13行：780
; 	25行：F00~F9F
; 1010000
; 属性

; | 闪烁BL | 背景RGB | 高亮I | 前景RGB |
; | ---- | ----- | --- | ----- |
; | 7    | 654   | 3   | 210   |

; 红底绿字：01000010B
; 红底闪烁绿字：11000010B
; 红底高亮绿字：01001010B
; 黑底白字：00000111B
; 白底蓝字：01110001B
; GBG:   MOV  BX,8000H


ASSUME CS:CODESG,DS:DATASG
DATASG SEGMENT
	       DB 'welcome to masm!'
DATASG ENDS

CODESG SEGMENT
	START: MOV  AX,DATASG
	       MOV  ES,AX

	       MOV  AX,STACKSG
	       MOV  SS,AX
	       MOV  SP,10H

	       MOV  AX,0B800H
	       MOV  DS,AX
	       MOV  BX,6E0H


	       MOV  CX,16
	       MOV  AH,02H
	       MOV  SI,0
	       MOV  DI,0
	G:     MOV  AL,ES:[DI]
	       MOV  DS:[BX+40H][SI],AX
	       INC  DI
	       ADD  SI,2
	       LOOP G

	       ADD  BX,0A0H

	       MOV  CX,16
	       MOV  AH,24H
	       MOV  SI,0
	       MOV  DI,0
	R:     MOV  AL,ES:[DI]
	       MOV  DS:[BX+40H][SI],AX
	       INC  DI
	       ADD  SI,2
	       LOOP R

	       ADD  BX,0A0H

	       MOV  CX,16
	       MOV  AH,71H
	       MOV  SI,0
	       MOV  DI,0
	B:     MOV  AL,ES:[DI]
	       MOV  DS:[BX+40H][SI],AX
	       INC  DI
	       ADD  SI,2
	       LOOP B

	FINISH:MOV  AX,4C00H
	       INT  21H

CODESG ENDS

END START