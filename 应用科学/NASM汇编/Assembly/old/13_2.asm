assume cs:code
code segment
start:
	mov ax,3456 ;(ax)=3456
	int 7ch ;调用中断7ch的中断例程，计算ax中的数据的平方
	add ax,ax
	adc dx,dx ;dx:ax存放结果，将结果乘以2
	mov ax,4c00h
	int 21h
code ends
end start