SYSSIZE = 0x3000

.globl begtext, begdata, begbss, endtext, enddata, endbss
.text
begtext:
.data
begdata:
.bss
begbss:
.text

SETUPLEN = 4
BOOTSEG  = 0x07c0
INITSEG  = 0x9000
SETUPSEG = 0x9020
SYSSEG   = 0x1000
ENDSEG   = SYSSEG + SYSSIZE

ROOT_DEV = 0x306

entry _start
_start:
    mov ax,#BOOTSEG
    mov ds,ax
    mov ax,#INITSEG
    mov es,ax
    mov cx,#0x200
    xor si,si
    xor di,di
    rep
    movw
    jmpi go,INITSEG

go: mov ax,cs
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov sp,#0xFF00  ; 任意>>512的值

; 载入setup模块
load_setup:
    mov dx,#0x0000  ; 设备0 磁头0
    mov cx,#0x0002  ; 扇区2 磁道0
    mov bx,#0x0200
    mov ax,#0x0200+SETUPLEN ; 2读取 扇区数
    int 0x13        ; 磁盘相关
    jnc ok_load_setup

err_load_setup:
    mov ax,#0x0000
    mov dx,#0x0000  ; 0复位
    int	0x13        ; 磁盘相关
    jmp load_setup

ok_load_setup:
    mov dl,#0x00
    mov ax,#0x0800  ; 8查询信息
    int 0x13        ; 磁盘相关
    mov ch,#0x00    ; 逻辑问题，实现正常，不能处理柱面大于256的软盘
    seg cs
    mov sectors,cx  ; 软盘扇区数量

output_msg:
    mov ax,#INITSEG
    mov es,ax
    xor bh,bh
    mov ah,#0x03    ; 获取光标位置, 返回bh
    int 0x10        ; bios程序

    mov cx,#28      ;
    mov bx,#0x0027
    mov bp,#msg1
    mov ax,#0x1301  ; 输出字符
    int 0x10        ; int 0x10:19


    ; 载入system
load_system:
    mov ax,#SYSSEG
    mov es,ax       ; 将数据段设置为 0x1000
    call    read_sys
    call    kill_motor  ; 通过关闭软盘驱动，初始化软盘状态

select_root:
    seg cs
    mov ax,root_dev ;
    cmp ax,#0       ; 判断根设备是否被定义为0
    jne define_root

    seg cs
    mov bx,sectors  ; 读取扇区数

    mov ax,#0x0208  ; 对应设备号为(2,08)
    cmp bx,#15      ; 15扇区 /dev/at0
	je	define_root
	mov ax,#0x021c  ; 对应设备号为(2,28)
	cmp bx,#18      ; 18扇区 80磁道 /dev/ps0
	je	define_root
	; 可以添加其他类型设备
undef_root:
    jmp undef_root ; 未知设备

define_root:
    seg cs
    mov root_dev,ax ;定义设备类型

    jmpi 0,SETUPSEG

; system固定加载在地址0x10000处，确保在64KB的界限被跨越
; 尽可能快

;
; 输入: es - 起始地址段（通常为0x1000）
;
sread:	.word 1+SETUPLEN	; 当前磁道已读扇区数
head:   .word 0     ; 当前的头
track:  .word 0     ; 当前磁道

read_sys:
    mov ax,es
    test ax,#0x0fff ; 检查当前段是否在第64个段位置
err_read_sys:
    jne err_read_sys

    xor bx,bx       ; 段内起始地址
read_loop:
    mov ax,es       ; 获取当前段
    cmp ax,#ENDSEG  ; 判断sys段是否加载完成
    jb  read_before    ;
    ret
read_before:
	seg cs
	mov ax,sectors  ;
	sub ax,sread    ; 要读取扇区计数 = 当前磁道扇区数-当前磁道已读扇区数
	mov cx,ax       ;
	shl cx,#9       ; 当前磁道未读字节数

	add cx,bx       ;
	jnc reading     ; 未溢出或!=0表示 bx超出当前磁道可读取最大值
	je  reading     ;

	xor ax,ax       ;
	sub ax,bx       ; 当前磁道未读扇区归零
	shr ax,#9       ; 调整当前磁道剩余扇区
reading:            ;
	call read_track ;
	mov cx,ax       ; 获取本次读取扇区计数
	add ax,sread    ;
	
	seg cs          ;
	cmp ax,sectors  ;
	jne up_read_out ; 判断是否超出扇区范围
up_read_head:       ;
	mov ax,#1       ;
	sub ax,head     ; 当head不是第一个磁头时
	jne up_read_head_end;
	inc track       ;
up_read_head_end:   ;
	mov head,ax     ;
	xor ax,ax       ;
up_read_out:
	mov sread,ax    ; 保存磁道已读扇区数
	shl cx,#9       ;
	add bx,cx       ; 存放地址 + 512 * 读取扇区
	jnc read_loop     ; 没有溢出则跳转

	mov ax,es       ; 溢出则
	add ax,#0x1000  ;
	mov es,ax       ; 转移到下一个段区
	xor bx,bx       ; 段内起始地址归零
	jmp read_loop     ;

; 读取磁道
read_track:
	push ax
	push bx
	push cx
	push dx

	mov dx,track
	mov cx,sread
	inc cx
	mov ch,dl
	mov dx,head
	mov dh,dl
	mov dl,#0
	and dx,#0x0100
	mov ah,#2
	int 0x13
	jc  bad_rt

	pop dx
	pop cx
	pop bx
	pop ax
	ret
bad_rt:
    mov ax,#0
	mov dx,#0
	int 0x13    ; 磁盘复位
	pop dx
	pop cx
	pop bx
	pop ax
	jmp read_track


kill_motor:
	push dx
	mov dx,#0x3f2
	mov al,#0   ; 将软盘数字控制寄存器（DOR）所有标志设置为0，从而关闭软盘
	outb
	pop dx
	ret


sectors:
    .word 0
msg1:
    .byte 13,10
    .ascii "Han-Linux0.11 start..." 
    .byte 13,10,13,10
root_dev:
    .word ROOT_DEV
boot_flag:
    .org 510    ; 将0xAA55放置在扇区末尾511处
    .word 0xAA55

.text
endtext:
.data
enddata:
.bss
endbss:
