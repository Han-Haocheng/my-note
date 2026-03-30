## write函数

![[计算机科学/操作系统/attachments/20250624170514.svg]]

### 创建write函数

文件：linux/lib/write.c

```C
#include<unistd.h>

_syscall3(int,write,int,fd,const char *,buf,off_t,count);
```

文件：linux/include/unistd.h

```C
#define _syscall3(type,name,atype,a,btype,b,ctype,c)\
type name(atype,a,btype,b,ctype,c){\
	long __res;\
	__asm__ volatile("int 0x80" :"=a"(__res):""(__NR_##name),"b"((long)(a)),"c"((long)(b)),"d"((long)(c)));\
	if(__res>=0)return (type)__res;\
	errno=-__res;\
	return -1;\
}
#define __NR_write 4
```

函数展开

```c
int write(int fd,const char* buf,off_t count){
	long __res;
	__asm__ volatile("int 0x80":"=a"(__res):""(__NR_write),
		"b"((long)(fd)),"c"((long)(buf)),"d"((long)(count)));

	
	if(__res>=0) 
		return (int)__res;
	errno=-__res;
	return -1;
}
```

asm展开
```asm
mov __NR_write,%eax
mov fd,%ebx
mov buf,%ecx
mov count,%edx
int 0x80
```

### 初始化中断向量

kernel/sched.c
```c
void sched_init(void){
	int i;
	struct desc_struct * p;

	if (sizeof(struct sigaction) != 16)
		panic("Struct sigaction MUST be 16 bytes");
	set_tss_desc(gdt+FIRST_TSS_ENTRY,&(init_task.task.tss));
	set_ldt_desc(gdt+FIRST_LDT_ENTRY,&(init_task.task.ldt));
	p = gdt+2+FIRST_TSS_ENTRY;
	for(i=1;i<NR_TASKS;i++) {
		task[i] = NULL;
		p->a=p->b=0;
		p++;
		p->a=p->b=0;
		p++;
	}
/* 清除NT，这样我们以后就不会有麻烦了 */
	__asm__("pushfl ; andl $0xffffbfff,(%esp) ; popfl");
	ltr(0);
	lldt(0);
	outb_p(0x36,0x43);		/* 二进制, mode 3, LSB/MSB, ch 0 */
	outb_p(LATCH & 0xff , 0x40);	/* LSB */
	outb(LATCH >> 8 , 0x40);	/* MSB */
	set_intr_gate(0x20,&timer_interrupt);
	outb(inb_p(0x21)&~0x01,0x21);


	//0x80中断
	set_system_gate(0x80,&system_call);
}
```

中断设置宏

```c
#define set_system_gate(n,addr)\
_set_gate(&idt[n],15,3,addr); //idt：中断向量表基址

#define _set_gate(gate_addr,type,dpl,addr)\
__asm_("movw %%dx,%%ax\n\t""movw %0,%%dx\n\t""movl %%eax,%1\n\t""movl %%edx,%2"::"i"((short)(0x8000+(dpl<<13+type<<8))),"o"(*((char*)(gate_addr))),"o"(*(4+(char*)(gate_addr))),"d"((char*)(addr)),"a"(0x00080000))
```

中断函数展开

```c
void sched_init(void){
	//...
	_set_gate(&idt[0x80],15,3,&system_call);
}

void sched_init(void){
	//...
	__asm__("movw %%dx,%%ax\n\t"
				 "movw %0,%%dx\n\t"
				 "movl %%eax,%1\n\t"
				 "movl %%edx,%2"
				 ::"i"((short)(0x8000+((3<<13)+15<<8))), //输入
				 "o"(*((char*)(&idt[0x80]))),            //输出
				 "o"(*(4+(char*)(&idt[0x80]))),
				 "d"((char*)(&system_call)),
				 "a"(0x00080000));
}

```

汇编部分

```asm
movl $0x00080000,%eax
movl $system_call,%edx

movw %dx,%ax
movw 0x9800,%dx
movl %eax,idt+0x80*8
movl %edx,idt+0x80*8+4
```

| 段选择符   | 入口偏移         | p   | dpl | s   | type |
| ------ | ------------ | --- | --- | --- | ---- |
| 0x0008 | &system_call | 1   | 11  | 1   | 1111 |

### 系统中断调用

linux/kernel/system_call.s

```
nr_system_calls=72
.globl system_call
system_call:
	cmpl $nr_system_calls-1,%eax
	ja bad_sys_call
	push %ds
	push %es
	push %fs
	pushl %edx
	pushl %ecx
	pushl %ebx
	movl $0x10,%edx
	mov %dx,%ds
	mov %dx,%es
	movl $0x17,%edx
	mov %dx,%fs
	call sys_call_table(,%eax,4)
	pushl %eax
	...
ret_from_sys_call:
		popl %eax
	...
```

### 系统中断调用表

include/linux/sched.h

```
typedef int (fn_ptr*)();
```

include/linux/sys.h

```C
fn_ptr sys_call_table[]={
	sys_setup,
	sys_exit,
	sys_fork,
	sys_read,
	sys_write,
	...
}
```

