assume cs:codesg
codesg segment
	mov ax,4c00h        ; +3
	int 0021H			; +2
start:					; 00001010B 10 
	mov ax,0    		; +3
s:						; 
	nop 				;
	nop  				; 20+f6 16
	mov di,offset s 	;
	mov si,offset s2	;
	mov ax,cs:[si]		;
	mov cs:[di],ax    	; 将s2前两个字节复制到s处
s0:						; 
	jmp short s       	; +2
s1:
	mov ax,0 		 	; +3
	int 21h           	; +2
	mov ax,0         	; +3   cs:ip=
s2:   					; 
	jmp short s1      	; +2   cs:ip=20h cs:ip-=
	nop
codesg ends
end start