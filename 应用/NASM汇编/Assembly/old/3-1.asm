assume cs:code
code segment
start:
	mov ax,0FFFFH
	mov ds,ax
	mov bx,6
	
	mov ax,0
	mov al,[bx]
	
	mov cx,3
s:
	add dx,ax
	loop s
	
	mov ax,4C00H
	int 21H
code ends
end start