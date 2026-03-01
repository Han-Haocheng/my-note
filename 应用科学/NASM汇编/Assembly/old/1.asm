assume cs:abc

abc segment

  mov ax,0002H
  add ax,ax
  add ax,ax
  mov ax,4C00H
  int 0021H
abc ends

end