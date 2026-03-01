assume cs:codesg,ds:datasg
datasg segment
	db 'BaSic'
	db 'iNfOrMaTiOn'
datasg ends

codesg segment
start:
	mov ax,datasg
	mov ds,ax
	mov bx,0
	mov cx,5
s0:
	mov al,[bx]
	and al,11011111b
	mov [bx],al
	inc bx
	loop s0

	mov cx,0BH
s1:
	mov al,[bx]
	or	al,00100000b
	mov [bx],al
	inc bx
	loop s1
	
	mov ax,4C00H
	int 0021H
codesg ends
end start