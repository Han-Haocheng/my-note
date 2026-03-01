assume cs:codesg
codesg segment
	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h ; +FH
	dw 0,0,0,0,0,0,0,0  ; +1FH
start:
	mov ax,cs
	mov ss,ax
	mov sp,20H
	
  mov bx,0
	mov cx,8H
pu:
	push cs:[bx]
  add bx,2
	loop pu

  mov bx,0
	mov cx,8H
po:
	pop cs:[bx]
  add bx,2
	loop po

	mov ax,4C00H
	int 21H
codesg ends
end start