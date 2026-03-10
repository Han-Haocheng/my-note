assume cs:code,ds:a,ds:b,ds:d

a segment
	db 1,2,3,4,5,6,7,8
a ends

b segment
	db 1,2,3,4,5,6,7,8
b ends

d segment
	db 0,0,0,0,0,0,0,0
d ends

code segment
start:
	mov	ax,d
	mov	ds,ax
	mov ax,a
	mov es,ax
	mov bx,0
	mov	cx,8
s0:
	mov	al,es:[bx]
	mov	ds:[bx],al
	inc	bx
	loop	s0

	mov	ax,b
	mov	es,ax
	mov	bx,0
	mov	cx,8
s1:	
	mov al,es:[bx]
	add ds:[bx],al
	inc bx
	loop	s1

	mov ax,4C00H
	int 0021H
code ends
end start