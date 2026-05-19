# int指令

`int n`指令：n为中断类型码，引发中断过程，最终功能和 call指令相似，都是调用一段程序。

1. 取中断类型码n;
2. 标志寄存器入栈，IF=0,TF=0;
3. CS、IP入栈；
4. `(IP)=(n*4),(CS)=(n*4+2)`

```
assume cs:code
code segment
start:
	mov ax,Ob800h
	mov es,ax
	mov byte ptr es:[12*160+40*2],'!'
	int 0
code ends
end start
```

## 编写供应用程序调用的中断例程

### 问题一：编写、安装中断7ch的中断例程

功能：求一 word型数据的平方。
参数：(ax)=要计算的数据。
返回值：dx、ax中存放结果的高16位和低16位。
应用举例：求$2\times3456^2$


主程序

```
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
```

安装程序

```
ASSUME CS:CODE

CODE SEGMENT
  START:MOV  AX,CS
        MOV  DS,AX
        MOV  SI,OFFSET SQR

        MOV  AX,0
        MOV  ES,AX
        MOV  DI,200H

        MOV  CX,OFFSET SQRED-OFFSET SQR
        CLD
        REP  MOVSB

        MOV WORD PTR ES:[4*7CH],200H
        MOV WORD PTR ES:[4*7CH+2],0

        MOV  AX,4C00H
        INT  21H
        
  SQR:  MUL  AX
        IRET
  SQRED:NOP
CODE ENDS
END START
```


### 问题二：编写、安装中断7ch的中断例程。
功能：将一个全是字母，以0结尾的字符串，转化为大写。
参数：ds:si指向字符串的首地址。
应用举例：将data段中的字符串转化为大写。
```
ASSUME CS:CODE,DS:DATA
DATA SEGMENT
	     DB 'conversation',0
DATA ENDS
CODE SEGMENT
	START:  MOV  AX,CS
	        MOV  DS,AX
	        MOV  SI,OFFSET CAPITAL

	        MOV  AX,0
	        MOV  ES,AX
	        MOV  DI,200H

	        MOV  CX,OFFSET CPL_ED - OFFSET CAPITAL
	        CLD
	        REP  MOVSB

	        MOV  WORD PTR ES:[4*7CH],200H
	        MOV  WORD PTR ES:[4*7CH+2],0
	
	MAIN:   MOV  AX,DATA
	        MOV  DS,AX
	        MOV  SI,0
	        INT  7CH

	        MOV  AX,4C00H
	        INT  21H

	CAPITAL:PUSH SI
	        PUSH CX
	L:      MOV  CL,DS:[SI]
	        MOV  CH,0
	        AND  BYTE PTR DS:[SI],11011111B
	        JCXZ OK
	        INC  SI
	        JMP  SHORT  L
	OK:     POP  CX
	        POP  SI
	        IRET
	CPL_ED: NOP
CODE ENDS
END START
```


### 对int、iret和栈的深入理解

; 问题：用7ch中断例程完成loop 指令的功能。
; loop s 的执行需要两个信息，循环次数和到s的位移，所以，7ch 中断例程要完成loop指令的功能，也需要这两个信息作为参数。
; 我们用cx存放循环次数，用bx存放位移。
; 应用举例：在屏幕中间显示80个‘!’。
```
ASSUME CS:CODE
CODE SEGMENT
  START:MOV  AX,CS
        MOV  DS,AX
        MOV  SI,OFFSET LOP
        
        MOV  AX,0
        MOV  ES,AX
        MOV  DI,200H

        MOV  CX,OFFSET LOPE - OFFSET LOP
        CLD
        REP  MOVSB

        MOV  WORD PTR ES:[4*7CH],200H
        MOV  WORD PTR ES:[4*7CH+2],0
  
        MOV  AX,0B800H
        MOV  ES,AX
        MOV  DI,160*12
        MOV  BX,OFFSET S-OFFSET SE
        MOV  CX,80
  
  S:    MOV  BYTE PTR ES:[DI],'!'
        ADD  DI,2
        INT  7CH
  SE:   NOP

        MOV  AX,4C00H
        INT  21H

  LOP:  PUSH BP
        MOV  BP,SP
        DEC  CX
        JCXZ OK
        ADD  [BP+2],BX
  OK:   POP BP
        IRET
  LOPE: NOP

CODE ENDS
END START
```

7ch中断例程实现loop的功能，则上面的7ch 中断例程所能进行的最大转移位移是一个段内

(2)用7ch 中断例程完成jmp near ptr s指令的功能，用bx向中断例程传送转移位移。
应用举例：在屏幕的第12行，显示data段中以0结尾的字符串。
```
ASSUME CS:CODE
DATA SEGMENT
       DB 'conversation',0
DATA ENDS
CODE SEGMENT
  START:MOV  AX,CS
        MOV  DS,AX
        MOV  SI,OFFSET JNR

        MOV  AX,0
        MOV  ES,AX
        MOV  DI,200H

        MOV  CX,OFFSET JNRE - OFFSET JNR
        CLD
        REP  MOVSB

        MOV  WORD PTR ES:[4*7CH],200H
        MOV  WORD PTR ES:[4*7CH+2],0
        MOV  AX,DATA
        MOV  DS,AX
        MOV  SI,0
        MOV  AX,0B800H
        MOV  ES,AX
        MOV  DI,12*160

  S:    CMP  BYTE PTR[SI],0
        JE   OK                           ;如果是0跳出循环
        MOV  AL,[SI]
        MOV  ES:[DI],AL
        INC  SI
        ADD  DI,2
        MOV  BX,OFFSET S-OFFSET OK        ;设置从标号OK到标号S的转移位移
        INT  7CH                          ;转移到标号S处
  OK:   MOV  AX,4C00H
        INT  21H
        
  ; 参数：bx 位移
  JNR:  PUSH BP
        MOV  BP,SP
        ADD  [BP+2],BX
        POP  BP
        IRET
  JNRE: NOP
CODE ENDS
END START
```

## BIOS和DOS所提供的中断例程

BIOS(基本输入输出系统)：在系统板的ROM中存放着一套程序

1. 硬件系统的检测和初始化程序
2. 外部中断(第15章中进行讲解)和内部中断的中断例程
3. 用于对硬件设备进行I/O操作的中断例程
4. 其他和硬件系统相关的中断例程


### BIOS和 DOS中断例程的安装过程

1. CPU初始化(CS)=0FFFFH,(IP)=0,自动从FFFF:0单元开始执行程序
	- FFFF:0处有一条转跳，用于执行BIOS中的硬件系统检测和初始化程序
2. 初始化程序将建立BIOS所支持的中断向量，即将BIOS 提供的中断例程的入口地址登记在中断向量表中
	- 对于BIOS所提供的中断例程，只需将入口地址登记在中断向量表中即可，因为它们是固化到ROM中的程序，一直在内存中存在。
3. 硬件系统检测和初始化完成后，调用int 19h 进行操作系统的引导
4. DOS 启动后，除完成其他工作外，还将它所提供的中断例程装入内存，并建立相应的中断向量

### BIOS中断例程应用

`int 10h` 中断例程：BIOS 提供的中断例程，包含多个和屏幕输出相关的子程序，
- 设置光标位置功能
	- (ah)=2：调用第10h号中断例程的2号子程序，功能为设置光标位置，可以提供光标所在的行号(80x25 字符模式下：0~24)、列号(80x25 字符模式下：0~79),和页号作为参数
	- (bh)=0,(dh)=5,(dl)=12,设置光标到第0页，第5行，第12列
```
mov ah,2  ;置光标
mov bh,0  ;第0页
mov dh,5  ;dh中放行号
mov dl,12 ;dl中放列号
int 10h
```
- 在光标位置显示字符功能
	- (ah)=9表示调用第10h号中断例程的9号子程序，功能为在光标位置显示字符，可以提供要显示的字符、颜色属性、页号、字符重复个数作为参数。

| 7   | 6 5 4 | 3   | 2 1 0 |
| --- | ----- | --- | ----- |
| BL  | R G B | I   | R G B |
| 闪烁  | 背景    | 高亮  | 前景    |

```
mov ah,9   ;在光标位置显示字符
mov al,'a' ;字符
mov bl,7   ;颜色属性
mov bh,0   ;第0页
mov cx,3   ;字符重复个数
int 10h
```

编程：在屏幕的5行12列显示3个红底高亮闪烁绿色的'a'
```
ASSUME CS:CODE
CODE SEGMENT
  START:MOV AH,2
        MOV BX,0
        MOV DH,5
        MOV DL,12
        INT 10H

        MOV AH,9
        MOV AL,'a'
        MOV BL,11001010B
        MOV BH,0
        MOV CX,3
        INT 10H
        
        MOV AX,4C00H
        INT 21H
CODE ENDS
END START
```

### DOS中断例程应用

int 21h中断例程

- 4ch号功能：程序返回功能
	- (ah)=4ch表示调用第21h号中断例程的4ch号子程序，功能为程序返回，可以提供返回值作为参数
```
mov ah,4ch;程序返回
mov al,0;返回值
int 21h
```

- 在光标位置显示字符串的功能
	- ds:dx指向字符串; 要显示的字符串需用"$"作为结束符
	- (ah)=9表示调用第21h号中断例程的9号子程序，功能为在光标位置显示字符串，可以提供要显示字符串的地址作为参数
```
mov ah,9 ;功能号9,表示在光标位置显示字符串
int 21h
```

