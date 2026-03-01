assume cs:abc

abc segment

start:
  mov ax, 2000H   ; 2000:1000H BE 00
  mov ds, ax
  mov bx, 1000H
  mov ax,[bx]
  inc bx
  inc bx
  mov [bx],ax
  inc bx
  inc bx
  mov [bx],ax
  inc bx
  mov [bx],al
  inc bx
  mov [bx],al

  mov ax, 4C00H
  int 0021H

abc ends

end start1