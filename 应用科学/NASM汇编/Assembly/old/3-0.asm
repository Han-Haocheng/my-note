assume cs:code

code segment

start:
  mov ax,2
  mov cx,12
_l:
  add ax,ax
  loop _l

  mov ax,4C00H
  int 21H
code ends

end start