INITSEG  = 0x9000    ;  初始短
SYSSEG   = 0x1000    ;  系统段
SETUPSEG = 0x9020    ;  setup段

.globl begtext, begdata, begbss, endtext, enddata, endbss
.text
begtext:
.data
begdata:
.bss
begbss:
.text

entry start
start:
    mov ax,#INITSEG
    mov ds,ax
    mov ax,#SETUPSEG
    mov es,ax
    ;  获取并保存光标位置
    mov ah,#0x03
    xor bh,bh
    int 0x10
    mov [0],dx ;  保存鼠标位置到 0x90000

    ;  获取内存大小
    mov ah,#0x88
    int 0x150x1B
    mov [2],ax
    mov bx,#2
    mov cx,#2
    mov bp,#msg_mem+12
    call num_to_string
    mov	cx,#20
    mov	bp,#msg_mem
    call print_msg

    ; 获取显卡参数
    mov ah,#0x0f
    int 0x10
    mov [4],bx
    mov [6],ax

    mov bx,#4
    mov cx,#2
    mov bp,#msg_vc1+12
    call num_to_string
    mov	cx,#18
    mov	bp,#msg_vc1
    call print_msg

    xor bx,bx

    mov bx,#6
    mov cx,#1
    mov bp,#msg_vc2+12
    call num_to_string
    mov	cx,#16
    mov	bp,#msg_vc2
    call print_msg

    mov bx,#7
    mov cx,#1
    mov bp,#msg_vc3+12
    call num_to_string
    mov	cx,#16
    mov	bp,#msg_vc3
    call print_msg

    ;  检查EGA/VGA等显示设备参数
    mov	ah,#0x12
    mov	bl,#0x10
    int	0x10
    mov	[8],ax  ;
    mov	[10],bx ;
    mov	[12],cx ;

stop:
    jmp stop


; 获取硬盘0的参数表

	mov	ax,#0x0000
	mov	ds,ax
	lds	si,[4*0x41] ; 硬盘0 参数表地址，位于系统中断0x41
	mov	ax,#INITSEG
	mov	es,ax
	mov	di,#0x0080
	mov	cx,#0x10
	rep
	movsb

; 获取硬盘1的参数表

	mov	ax,#0x0000
	mov	ds,ax
	lds	si,[4*0x46] ; 硬盘0 参数表地址，位于系统中断0x46
	mov	ax,#INITSEG
	mov	es,ax
	mov	di,#0x0090
	mov	cx,#0x10
	rep
	movsb

; 检查是否有硬盘1

	mov	ax,#0x01500 ; ah=0x15 获取硬盘类型
	mov	dl,#0x81    ; 设备号，第七位表示硬盘
	int	0x13
	jc	no_disk1
	cmp	ah,#3
	je	is_disk1
no_disk1:
	mov	ax,#INITSEG
	mov	es,ax
	mov	di,#0x0090
	mov	cx,#0x10
	mov	ax,#0x00
	rep
	stosb
is_disk1:

; now we want to move to protected mode ...

	cli			; no interrupts allowed ;

; first we move the system to its rightful place

	mov	ax,#0x0000
	cld			; 'direction'=0, movs moves forward
do_move:
	mov	es,ax		; destination segment
	add	ax,#0x1000
	cmp	ax,#0x9000
	jz	end_move
	mov	ds,ax		; source segment
	sub	di,di
	sub	si,si
	mov 	cx,#0x8000
	rep
	movsw
	jmp	do_move

; then we load the segment descriptors

end_move:
	mov	ax,#SETUPSEG	; right, forgot this at first. didnt work :-)
	mov	ds,ax
	lidt	idt_48		; load idt with 0,0
	lgdt	gdt_48		; load gdt with whatever appropriate

; that was painless, now we enable A20

	call	empty_8042
	mov	al,#0xD1		; command write
	out	#0x64,al
	call	empty_8042
	mov	al,#0xDF		; A20 on
	out	#0x60,al
	call	empty_8042

; well, that went ok, I hope. Now we have to reprogram the interrupts :-(
; we put them right after the intel-reserved hardware interrupts, at
; int 0x20-0x2F. There they won't mess up anything. Sadly IBM really
; messed this up with the original PC, and they haven't been able to
; rectify it afterwards. Thus the bios puts interrupts at 0x08-0x0f,
; which is used for the internal hardware interrupts as well. We just
; have to reprogram the 8259's, and it isn't fun.

	mov	al,#0x11		; initialization sequence
	out	#0x20,al		; send it to 8259A-1
	.word	0x00eb,0x00eb		; jmp $+2, jmp $+2
	out	#0xA0,al		; and to 8259A-2
	.word	0x00eb,0x00eb
	mov	al,#0x20		; start of hardware int s (0x20)
	out	#0x21,al
	.word	0x00eb,0x00eb
	mov	al,#0x28		; start of hardware int s 2 (0x28)
	out	#0xA1,al
	.word	0x00eb,0x00eb
	mov	al,#0x04		; 8259-1 is master
	out	#0x21,al
	.word	0x00eb,0x00eb
	mov	al,#0x02		; 8259-2 is slave
	out	#0xA1,al
	.word	0x00eb,0x00eb
	mov	al,#0x01		; 8086 mode for both
	out	#0x21,al
	.word	0x00eb,0x00eb
	out	#0xA1,al
	.word	0x00eb,0x00eb
	mov	al,#0xFF		; mask off all interrupts for now
	out	#0x21,al
	.word	0x00eb,0x00eb
	out	#0xA1,al

; well, that certainly wasn't fun :-(. Hopefully it works, and we don't
; need no steenking BIOS anyway (except for the initial loading :-).
; The BIOS-routine wants lots of unnecessary data, and it's less
; "interesting" anyway. This is how REAL programmers do it.
;
; Well, now's the time to actually move into protected mode. To make
; things as simple as possible, we do no register set-up or anything,
; we let the gnu-compiled 32-bit programs do that. We just jump to
; absolute address 0x00000, in 32-bit protected mode.
	mov	ax,#0x0001	; protected mode (PE) bit
	lmsw	ax		; This is it;
	jmpi	0,8		; jmp offset 0 of segment 8 (cs)

; This routine checks that the keyboard command queue is empty
; No timeout is used - if this hangs there is something wrong with
; the machine, and we probably couldnt proceed anyway.

empty_8042:
	.word	0x00eb,0x00eb
	in	al,#0x64	; 8042 status port
	test	al,#2		; is input buffer full?
	jnz	empty_8042	; yes - loop
	ret



;  in ds:bx - number point
;  in cx - number size
;  in es:bp - output point
num_to_string:
    push ax
    push cx
    push si
    push di

    xor si,si
    mov di,cx
    add di,di

convert_loop:
    sub di,#2
    seg ds
    mov al,(bx+si)
    call byte_to_ascii
    seg es
    mov (bp+di),ax
    inc si
    loop convert_loop       ;  循环直到ecx=0

    pop di
    pop si
    pop cx
    pop ax
    ret

;  in al num
;  out ax ascii
byte_to_ascii:
	push bx
	push cx

	mov ah,al
	shr ah,#0x4
	mov cx,#0x0F0F
	and ax,cx

	xor bx,bx
	mov bl,al
    seg es
	mov al,#num_map(bx)

	xor bx,bx
	mov bl,ah
    seg es
	mov ah,#num_map(bx)

	mov bl,al
	mov al,ah
	mov ah,bl

	pop cx
	pop bx
	ret

; es:bp - print string point
; cx - string size
; ds:[0] - save current cursor location
print_msg:
    push bx
    push ax
    push dx

    seg ds

    mov dx,[0]
    mov	bx,#0x0007		;  page 0, attribute 7 (normal)
    mov	ax,#0x1301		;  write string, move cursor
    int	0x10

    seg es
    mov ah,#0x03
    xor bh,bh
    int 0x10

    seg ds
    mov [0],dx ;  保存鼠标位置到 0x90000

    pop dx
    pop ax
    pop bx
    ret

gdt:
	.word	0,0,0,0		; dummy

	.word	0x07FF		; 8Mb - limit=2047 (2048*4096=8Mb)
	.word	0x0000		; base address=0
	.word	0x9A00		; code read/exec
	.word	0x00C0		; granularity=4096, 386

	.word	0x07FF		; 8Mb - limit=2047 (2048*4096=8Mb)
	.word	0x0000		; base address=0
	.word	0x9200		; data read/write
	.word	0x00C0		; granularity=4096, 386

idt_48:
	.word	0			; idt limit=0
	.word	0,0			; idt base=0L

gdt_48:
	.word	0x800		; gdt limit=2048, 256 GDT entries
	.word	512+gdt,0x9	; gdt base = 0X9xxxx


num_map:
    .ascii '0123456789ABCDEF'

msg_mem:
    .ascii 'memory size:    KB'
    .byte 13,10
msg_vc1:
    .ascii 'display pge:    '
    .byte 13,10

msg_vc2:
    .ascii 'video  mode:  '
    .byte 13,10

msg_vc3:
    .ascii 'wind  width:  '
    .byte 13,10

.text
endtext:
.data
enddata:
.bss
endbss:
