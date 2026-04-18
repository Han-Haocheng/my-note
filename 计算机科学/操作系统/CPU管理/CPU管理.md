# CPU 管理


CPU工作原理：CPU自动取指分析执行
- CPU管理直接方式：设置PC的初值
- IO指令与CPU之间的矛盾：IO指令与CPU之间的速度差距非常大，当CPU执行IO操作时，CPU需要等待IO完成
- IO会降低CPU的使用率

### 多道程序，交替执行

多道程序，交替执行(并发)：当发生IO时，将CPU的PC切换到其他程序执行，当IO完成是，IO接口发出中断指令，CPU继续执行下面的代码

![[计算机科学/操作系统/attachments/20250701130256.svg]]

![[计算机科学/操作系统/attachments/20250701130924.svg]]

| 设备   | CPU利用率               | DEV1利用率                | DEV2利用率                |
| ---- | -------------------- | ---------------------- | ---------------------- |
| 单道程序 | $\frac{40}{80}=0.5$  | $\frac{15}{80}=0.1875$ | $\frac{25}{80}=0.3125$ |
| 多道程序 | $\frac{40}{45}=0.89$ | $\frac{15}{45}=0.33$   | $\frac{25}{45}=0.56$   |

### 实现并行

记录程序上下文（下一条程序地址，各种寄存器），存放到PCB中

### 进程

进程：运行中的程序，有开始、等待、结束等状态，需要记录寄存器

## 调度单位


以下是根据内容整理的对比表格：

| 特性         | 进程                                                                 | 线程                                                                 |
|--------------|----------------------------------------------------------------------|----------------------------------------------------------------------|
| 调度单位     | 传统OS中是拥有资源和独立调度的基本单位；引入线程后是拥有资源的基本单位     | 引入线程的OS中是独立调度的基本单位                                     |
| 资源拥有     | 拥有系统资源（传统和有线程的OS都如此）                                   | 不拥有系统资源（仅有一点必要资源），可访问隶属进程的系统资源             |
| 切换影响     | 同一进程内线程切换不引起进程切换；不同进程间线程切换会引起进程切换         | 同一进程内线程切换不引起进程切换                                       |
| 并发性       | 进程间可并发执行（传统和有线程的OS都支持）                               | 引入线程的OS中，多个线程间可并发执行，提升系统吞吐量                     |
| 系统开销     | 创建/撤销进程时系统分配/回收资源，开销远大于线程；进程切换涉及CPU环境保存和新设置，开销大 | 线程切换只需保存/设置少量寄存器，开销小；同一进程线程地址空间相同，同步通信易，无需系统干预 |



## 调度点

调度点：引发调度的情况

### 初始化调度器

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
/* Clear NT, so that we won't have troubles with that later on */
	__asm__("pushfl ; andl $0xffffbfff,(%esp) ; popfl");
	ltr(0);
	lldt(0);
	outb_p(0x36,0x43);		/* binary, mode 3, LSB/MSB, ch 0 */
	outb_p(LATCH & 0xff , 0x40);	/* LSB */
	outb(LATCH >> 8 , 0x40);	/* MSB */
	set_intr_gate(0x20,&timer_interrupt); // 设置时钟中断
	outb(inb_p(0x21)&~0x01,0x21);
	set_system_gate(0x80,&system_call);
}
```

### 时钟中断

时钟中断：根据时钟的变化周期性发生中断


```c
_timer_interrupt:
	call do_timer

void do_timer(...){
	if((--current->counter>0))return;
	current->counter=0;
	schedule();
}
```

