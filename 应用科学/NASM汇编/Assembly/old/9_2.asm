assume cs:codesg
codesg segment
start:
	mov ax,0
	jmp short start
	add ax,1
s:
	inc ax
codesg ends
end start