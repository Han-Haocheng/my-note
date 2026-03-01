assume cs:code
code segment
start:
	mov ax,cs     ; 2B
	mov ds,ax     ; 2B
	mov ax,0020h  ; 3B
	mov es,ax     ; 2B
	mov bx,0      ; 3B
	mov cx,17H    ; 3B
s:mov al,[bx]   ; 2B
	mov es:[bx],al; 3B
	inc bx        ; 1B
	loop s        ; 2B
	mov ax,4c00h  ; 3B
	int 21h       ; 2B
code ends
end start
