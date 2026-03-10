# Call和Ret指令

call和ret指令：转移指令，修改IP或同时修改CS和IP，经常被共同用来实现子程序的设计

## `ret`和`retf`指令

### `ret`指令

ret指令：用栈中的数据，修改IP的内容，从而实现近转移
- (IP)=((ss)<<4+(sp))
- (sp)=(sp)+2

```
pop ip
```

```
assume cs:code
stack segment
	db 16 dup(0)
stack ends
code segment
	mov ax,4c00h
	int 21h
start: 
	mov ax,stack
	mov ss,ax
	mov sp,16
	mov ax,0
	push ax
	mov bx,0
	ret
code ends
end start
```


### `retf`指令

retf指令：用栈中的数据，修改CS和IP的内容，从而实现远转移
- (IP)=((ss)<<4+(sp))
- (sp)=(sp)+2
- (CS)=((ss)<<4+(sp))
- (sp)=(sp)+2

```
pop ip
pop cs
```

```
assume cs:code
stack segment
db 16 dup(0)
stack ends
code segment
	mov ax,4c00h
	int 21h
	start:
	mov ax,stack
	mov ss,ax
	mov sp,16
	mov ax,0
	push cs
	push ax
	mov bx,0
	retf
code ends
end start
```


检测点10.1：补全程序，实现从内存1000:0000处开始执行指令。

```
assume cs:code
stack segment
db 16 dup(0)
stack ends
code segment
	start: 
	mov ax,stack
	mov ss,ax
	mov sp,16
	mov ax,1000H
	push ax
	mov ax,0
	push ax
	retf
code ends
end start
```


## `call`指令

call 指令不能实现短转移
- 将当前的IP或CS和IP压入栈中
- 转移

### 根据位移进行转移

`call 标号`：将当前的IP压栈后，转到标号处执行指令
- (sp)=(sp)-2
- ((ss)<<4+(sp)=(IP)
- (IP)=(IP)+16位位移

```
push ip
jmp near ptr 标号
```

检测点10.2：下面的程序执行后，ax中的数值为1

| 内存地址   | 机器码      | 汇编指令     |
| ------ | -------- | -------- |
| 1000:0 | b8 00 00 | mov ax,0 |
| 1000:3 | e8 01 00 | call s   |
| 1000:6 | 40       | inc ax   |
| 1000:7 | 58       | s:pop ax |

### 转移目的地址在指令中

`call far ptr 标号`：实现的是段间转移
- (sp)=(sp)-2
- ((ss)<<4+(sp))=(CS)
- (sp)=(sp)-2
- ((ss)<<4+(sp))=(IP)
- (CS)=标号所在段的段地址
- (IP)=标号在段中的偏移地址


```
push CS
push IP
jmp far ptr 标号
```

检测点10.3：下面的程序执行后，ax中的数值为1012H

| 内存地址   | 机器码            | 汇编指令           |       |
| ------ | -------------- | -------------- | ----- |
| 1000:0 | b8 00 00       | mov ax,0       |       |
| 1000:3 | 9A 09 00 00 10 | call far ptr s |       |
| 1000:8 | 40             | inc ax         |       |
| 1000:9 | 58             | s:pop ax       |       |
|        |                | add ax,ax      | 12h   |
|        |                | pop bx         | 1000h |
|        |                | add ax,bx      | 1012h |

### 转移地址在寄存器中

`call 16位reg`
- (sp)=(sp)-2
- ((ss)<<4+(sp))=(IP)
- (IP)=(16位reg)

```
push IP
jmp 16位reg
```


检测点10.4：下面的程序执行后，ax中的数值为9

| 内存地址   | 机器码      | 汇编指令        |     |
| ------ | -------- | ----------- | --- |
| 1000:0 | b8 06 00 | mov ax,6    |     |
| 1000:3 | ff d0    | call ax     |     |
| 1000:5 | 40       | inc ax      |     |
| 1000:6 |          | mov bp,sp   |     |
|        |          | add ax,[bp] |     |


### 转移地址在内存中

`call word ptr 内存单元地址`

```
push IP
jmp word ptr内存单元地址
```

```
mov sp,10h
mov ax,0123h
mov ds:[0],ax
call word ptr ds:[0]
; (IP)=0123H,(sp)=0EH
```


`call dword ptr 内存单元地址`

```
push CS
push IP
jmp dword ptr 内存单元地址
```

```
mov sp,10h
mov ax,0123h
mov ds:[0],ax
mov word ptr ds:[2],0
call dword ptr ds:[0]

; (CS)=0,(IP)=0123H,(sp)=0CH。
```

检测点10.5：下面的程序执行后，ax 中的数值为4c00h/3

```
assume cs:code
stack segment
	dw 8 dup(0)
stack ends

code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,16
	
	mov ds,ax
	mov ax,0
	call word ptr ds:[0EH]  ; call 0:0
	
	inc ax
	inc ax
	inc ax
	
	mov ax,4c00h
	int 21h
code ends
end start
```

下面的程序执行后，ax和bx中的数值为1,0
```
assume cs:code
data segment
	dw 8 dup(0)
data ends
code segment
start:
	mov ax,data
	mov ss,ax
	mov sp,16
	
	mov word ptr ss:[0],offset s
	mov ss:[2],cs
	call dword ptr ss:[0]
	nop
s:
	mov ax,offset s
	sub ax,ss:[0CH]   ;ax=1
	mov bx,cs
	sub bx,ss:[0EH]   ;bx=0
	
	mov ax,4c00h
	int 21h
code ends
end start
```

## `call`和`ret`指令配合

问题10.1：下面程序返回前，bx中的值是8

```
assume cs:code
code segment
start:
	mov ax,1
	mov cx,3
	call s
	mov bx,ax   ;(bx)=8
	mov ax,4c00h
	int 21h
s:
	add ax,ax
	loop s
	ret
code ends
end start
```

```
assume cs:code
stack segment
	      db 8 dup(0)	; 1000:0000 00 00 00 00 00 00 00 00
	      db 8 dup(0)	; 1000:0008 00 00 00 00 00 00 00 00
stack ends
code segment
	start:
		mov  ax,stack	; 1001:0000 B8 00 10
		mov  ss,ax   	; 1001:0003 8E D0
		mov  sp,16   	; 1001:0005 BC 10 00

		mov  ax,1000 	; 1001:0008 B8 E8 03
		call s       	; 1001:000B E8 05 00  ;00000000000000000000000000000E00

		mov  ax,4c00h	; 1001:000E B8 00 4C	;00000000000000000000000000000000 
		int  21h     	; 1001:0011 CD 21

	s:    
		add  ax,ax   	; 1001:0013 03 CO     ;00000000000000000000000000000E00
		ret          	; 1001:0015 C3
code ends
end start
```

## `mul`指令

`mul`指令：乘法指令，可以进行8位或16位相乘
- `mul reg`、`mul 内存单元`

| 位数    | 乘数A  | 乘数B   | 乘积        |
| ----- | ---- | ----- | --------- |
| 8bit  | `AL` | 8bit  | `AX`      |
| 16bit | `AX` | 16bit | `DX`+`AX` |

## 模块化程序设计

模块化程序设计：将现实问题转换为相互联系，不同层次的子问题，利用call和ret指令

### 参数和结果传递问题

设计一个子程序，可以根据提供的N,来计算N的3次方
- 将参数N存储在什么地方?
	- 可以用寄存器来存储，可以将参数放到bx中
- 计算得到的数值，存储在什么地方?
	- 

```
;说明：计算N的3次方
;参数：(bx)=N
;结果：(dx:ax)=N^3
cube:
	mov ax,bx
	mul bx
	mul bx
	ret
```


编程，计算data段中第一组数据的3次方，结果保存在后面一组dword单元中。

```
assume cs:code
data segment
	dw 1,2,3,4,5,6,7,8
	dd 0,0,0,0,0,0,0,0
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov si,0
	mov di,16

	mov cx,8
s:mov bx,ds:[si]
	call cube
	mov ds:[di],ax
	mov ds:[di+2],dx
	add si,2
	add di,4
	loop s
	
cube:
	mov ax,bx
	mul bx
	mul bx
	ret
code ends
end start
```
### 批量数据的传递
如果需要传递的数据有N个，不能存储在寄存器中，则将参数保存在内存中，将内存地址传递给子程序，通用的方法是用栈来传递参数

编程，将data段中的字符串转化为大写。

```
assume cs:code
data segment
	db 'conversation'
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov si,0
	mov cx,12
	call capital

capital:
	and byte ptr [si],DFH
	inc si
	loop capital
	ret

code ends
end start
```

### 寄存器冲突问题

设计一个子程序，功能：将一个全是字母，以0结尾的字符串，转化为大写。

```
assume cs:code
data segment
db'conversation',0
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov si,0
	call capital

;说明：将一个全是字母，以0结尾的字符串，转化为大写
;参数：ds:si指向字符串的首地址
;结果：没有返回值
capital:
	mov cl,[si]
	mov ch,0
	jcxz ok
	and byte ptr [si],11011111b
	inc si
	jmp short capital
ok:
	ret

code ends
end start	
```

将data段中的字符串全部转化为大写。
```
assume cs:code
data segment
	db 'word′,0
	db 'unix',0
	db 'wind',0
	db 'good',0
data ends
stack segment
	dw 8 dup(0)
stack ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov bx,0

	mov ax,stack
	mov ss,ax
	mov sp,16
	
	mov cx,4
s:mov si,bx
	call capital
	add bx,5
	loop s
	
	mov ax,4c00h
	int 21h
	
capital: 
	push cx
	push si
	change: mov cl,[si] mov ch,0
	jcxz ok
	and byte ptr [si],11011111b
	inc si
	jmp short change
ok: 
	pop si
	pop cx
	ret
code ends
end start
```



## 实验10 编写子程序

1.显示字符串

显示字符串是现实工作中经常要用到的功能，应该编写一个通用的子程序来实现这个功能。我们应该提供灵活的调用接口，使调用者可以决定显示的位置(行、列)、内容和颜色。

子程序描述
名称：show_str
功能：在指定的位置，用指定的颜色，显示一个用0结束的字符串。
参数：
(dh)=行号(取值范围0~24),
(dl)=列号(取值范围0~79),
(cl)=颜色，
ds:si指向字符串的首地址
返回：无
应用举例：在屏幕的8行3列，用绿色显示data段中的字符串。

```
assume cs:code

data segment
db 'Welcome to masm!',0
data ends

stack segment
	dw 8 dup(0)
stack ends

code segment
start: 
	mov dh,8
	mov dl,3
	mov cl,2
	mov ax,data
	mov ds,ax
	mov si,0
	call show_str
	
	mov ax,4c00h
	int 21h
show_str:
	mov ax,0B800H
	mov es,ax
	mov di,0

	mov ax,dx
	mul ah
	mov ax,bx

	
code ends
end start
```

名称：divdw
功能：进行不会产生溢出的除法运算，被除数为dword型，除数为word型，结果为dword型。
参数：
(ax)=dword型数据的低16位
(dx)=dword型数据的高16位
(cx)=除数
返回：
(dx)=结果的高16位，
(ax)=结果的低16位
(cx)=余数
应用举例：计算1000000/10(F4240H/0AH)
mov ax,4240H
mov dx,000FH
mov cx,0AH
call divdw
结果：(dx)=0001H,(ax)=86AOH,(cx)=0
公式：$\frac{X}{N}=int\left( \frac{H}{N} \right)\times65536+\frac{\left[ rem\left( \frac{H}{N} \right)\times65536+L \right]}{N}$

```

ASSUME CS:CODESG,SS:STACKSG

STACKSG SEGMENT
               DW 8 DUP(0)
STACKSG ENDS

CODESG SEGMENT
       START: MOV  AX,STACKSG
              MOV  SS,AX
              MOV  SP,10H

              MOV  AX,4240H
              MOV  DX,000FH
              MOV  CX,0AH
              CALL DIVDW
         

       DIVDW: MOV  BX,AX            ;T1=L
              MOV  AX,DX
              MOV  DX,0
              DIV  CX               ;H/N =  AX int(H/N)
              MOV  BP,AX            ; T2= AX int(H/N)
              MOV  AX,BX
              DIV  CX
              MOV  CX,DX
              MOV  DX,BP
              RET
          
CODESG ENDS
END START

```


问题: 编程，将data段中的数据以十进制的形式显示出来。
名称：dtoc
功能：将word型数据转变为表示十进制数的字符串，字符串以0为结尾符。
参数：
(ax)=word型数据
ds:si指向字符串的首地址
返回：无
应用举例：编程，将数据12666 以十进制的形式在屏幕的8行3列，用绿色显示出来。在显示时我们调用本次实验中的第一个子程序show_str。
十进制数码字符对应的ASCII码= 十进制数码值+30H。

```
ASSUME CS:CODE,DS:DATASG,SS:STACKSG
DATASG SEGMENT
         DB 10 DUP(0)
DATASG ENDS
STACKSG SEGMENT
          DW 16 DUP(0)
STACKSG ENDS
CODE SEGMENT
  DTOC:    MOV  BX,10
           MOV  DX,0
           DIV  BX
           ADD  DL,30H
           MOV  DS:[SI],DL
           MOV  DX,0
           MOV  CX,AX
           JCXZ DTOC_OK
           INC  SI
           JMP  DTOC
  DTOC_OK: MOV  AX,0
           MOV  DS:[SI+1],AL
           RET
           
  SHOW_STR:MOV  AX,0B800H
           MOV  ES,AX

           MOV  AH,160
           MOV  AL,DH
           MUL  AH
           MOV  BX,AX

           MOV  AX,2
           MUL  DL
           MOV  DI,AX

           MOV  AL,CL
           MOV  AH,0
           MOV  CX,0
  SHOW_L:  MOV  CL,DS:[SI]
           MOV  ES:[BX][DI],CL
           MOV  ES:[BX][DI+1],AL
           INC  SI
           ADD  DI,2
           JCXZ SHOW_OK
           JMP  SHOW_L
  SHOW_OK: RET

  START:   MOV  AX,STACKSG
           MOV  SS,AX
           MOV  SP,20H
           MOV  AX,DATASG
           MOV  DS,AX
           MOV  SI,0
           MOV  AX,12666
           CALL DTOC
           MOV  SI,0
           MOV  DH,8
           MOV  DL,3
           MOV  CL,2
           CALL SHOW_STR
           MOV  AX,4C00H
           INT  21H
CODE ENDS
END START
```