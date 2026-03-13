; 计算 `ffff:0-ffff:b`单元的数据和，结果存放在dx中
assume cs:code

code segment
start:
  mov ax,0ffffh
  mov ds,ax   ; 数据段初始化
  mov bx,0    ; 地址偏移初始化
  mov dx,0    ; 数据初始化
  mov cx,12   ; 循环初始化

l:            ; 循环开始
  mov al,ds:[bx]
  mov ah,0
  add dx,ax
  inc bx
  loop l

  mov ax,4C00H
  int 21H
code ends

end start