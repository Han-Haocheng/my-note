# \[BX\]和loop指令

> [!tip]
> - 使用(X)表示地址X对应的值
> - 使用idata表示常量

## \[BX\]

\[BX\]：类似debug中的\[内存偏移\]操作
- `mov ax,[bx]`：将bx存放的偏移地址EA，ds存放的段地址SA，组成的SA:EA处的数据放入ax中
	- 即 `(ax)=((ds)<<4+(bx))`
- `mov ax,[bx]`：`((ds)<<4+(bx))=(ax)`

问题5.1：写出以下程序并执行

```asm
assume cs:abc
abc segment
start:
  mov ax, 2000H   ; 2000:1000H BE 00
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
end start
```
## Loop指令

loop指令：用于循环操作，CPU执行时，要进行两步动作`(CX)=(CX)+1`，
- 格式：`loop 标号`
- 动作：
	1. `(CX)=(CX)-1`
	2. 判断`(CX)==0`，如果为假则跳转到标号处，否则执行后面的代码
- 在loop循环时，`cx`通常存放循环次数

```asm
	mov cx,循环次数
S:
	循环体
	loop S
```

> [!question]
> 任务5.2.3：用loop编程计算$2^{12}$，结果存放在ax中
> 
> ```asm
> assume cs:abc
> abc segment
> start:
>     mov cx,11
>     mov ax,2
> _s: add ax,ax
> 	  loop _s
> 
> 	  mov ax, 4C00H
> 	  int 0021H
> abc ends
> end start
> ```

> [!question]
> 问题5.2：用加法计算$123\times236$，结果存放在`ax`中
> 
> ```asm
> assume cs:code
> code segment
> 
> start:
> 	mov ax,0
> 	mov cx,123
> S:
> 	add ax,236
> 	loop S
> 	mov ax,4C00H
> 	int 0021H
> code ends
> 
> end start
> ```

### 标号

标号：代表一个程序执行的地址

### 跟踪loop指令实现的循环程序

```
assume cs:code
code segment
start:
	mov ax, 0FFFFH
	mov ds,ax
	mov bx,6
	
	mov ax,0
	mov al,[bx]
	
	mov cx,3
s:
	add dx,ax
	loop s
	
	mov ax,4C00H
	int 21H
code ends
end start
```

> [!error]
> 汇编的源程序中不能以字母开头

> [!info]
> Debug和汇编编译器Masm对指令的不同处理
> - 汇编编译器不能识别类似\[idata\]这种写法，编译器会识别成常量idata
> - 因此需要使用寄存器间接取指\[BX\]，获取对应地址
> - 或者在源程序中使用 `ds:[idata]`

### Loop 和\[bx\]联合使用

计算 `ffff:0-ffff:b`单元的数据和，结果存放在dx中
1. 判断运算结果是否会超出dx范围：12个数据相加不会超过范围
2. 使用AX寄存器作为累加器：不能直接使用两个位数不相等的数据进行操作

```asm
; 计算 `ffff:0-ffff:b`单元的数据和，结果存放在dx中
assume cs:code

code segment
start:
  mov ax,0ffff
  mov ds,ax   ; 数据段初始化
  mov bx,0    ; 地址偏移初始化
  mov dx,0    ; 数据初始化
  mov cx,12   ; 循环初始化

l:            ; 循环开始
  mov al,ds:[bx]
  mov ah,0
  add dx,ax
  inc bx
  loop l:

  mov ax,4C00H
  int 21H
code ends

end starg
```

## 段前缀

段前缀：在地址格式类似为 `ds:[bx]`中的`ds:`

> [!tip]
> 安全内存空间：dos方式下，在地址空间 `0:200-0:2FF`这段空间通常是安全的

### 段前缀的使用

将`ffff:0-ffff:b`的数据14个数据复制到`0:200-0:2ff`中
- 将`0:200-0:20b`看作`20:0-20:b`


```asm

assume cs:code

code segment
start:
	mov ax,0FFFFH
	mov ds,ax
	mov ax,20H
	mov es,ax
	mov bx,0

	mov cx,0CH
l:	mov es:[bx],ds:[bx]
	loop l

	mov 4C00H
	int 21H
code ends
end start
```

- 编程，向内存0:200~0:23F依次传送数据0~63(3FH)。
- 编程，向内存0:200~0:23F 依次传送数据0~63(3FH),程序中只能使用9条指令，9条指令中包括“mov ax,4c00h”和“int 21h”。

```
assume cs:code
code segment
	mov ax,0020H
	mov ds,ax
	mov bx,0
	mov cx,003FH
s:mov ds:[bx],bx
	inc bx
	loop s
	mov ax,4c00H
	int 21H
code ends
end
```

- 下面的程序的功能是将“mov ax,4c00h”之前的指令复制到内存0:200处，补全程序。上机调试，跟踪运行结果。

```
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

```