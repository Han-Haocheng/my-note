---
tags:
  - 计算机科学/计算机网络/传输层
  - 类型/网络/协议
---

# TCP传输控制协议

TCP协议^[RFCs-793,1122,1323,2018]

 传输控制协议 TCP(Transmission Control Protocol)：提供面向连接的、可靠的数据传输服务
- 传输单元：报文段 segment
- 相关[[应用层]]协议：HTTP. FTP. SMTP.BGP


## 特点

特点：可靠、按序的交付服务，包含拥塞控制、流量控制、建立连接功能
- 点对点：一个发送方，一个接收方
- 可靠有序的字节流
- [[流水线机制]]：通过[[拥塞控制]]和[[CS计算机系统/计算机网络/网络体系结构/传输层/流量控制]]设置窗口尺寸
- 缓存机制：发送方接收方缓存
- 全双工full-duplex：同一连接能传输双向数据流
- 面向连接：发送数据前需要建立连接，只在两端维护，包括端点缓存，连接状态，socket等
- [[CS计算机系统/计算机网络/网络体系结构/传输层/流量控制]]

## 结构

![[2025-11-04_152651.svg]]

- 序号SEQ：段中第一个字节的编号，不是segment的编号
- 确认号ACK：希望收到的下一个字节的序列号，累积确认机制
- 数据偏移：4位，表示TCP首部长度，以4字节为单位
- 标志
	- ACK
	- SYN
	- FIN
	- RST：标识是否重置连接，值为0或1
	- URG：标识是否为紧急报文，配合紧急指针（urgent pointer）一起使用，值为0或1
	- PSH：标识是否立即把报文数据推送给应用层，值为0或1。如果TCP接收方接收到PSH为1的报文段，应尽快把这段报文数据从接收缓冲区中读出并立即推送给应用层，不必等到缓冲区写满后再推送。
- 窗口：接收窗口大小，用于流量控制
- 校验和：用来检验TCP头部和数据完整性
- 紧急指针：指示数据的位置，只有当URG标志被设置时使用

## 流程

### 连接过程
![[Pasted image 20260625185018.png]]
![[2025-11-24_084935.svg]]

| 步骤    | 发送方 | 接收方 | 关键标志位与序号                     |
| ----- | --- | --- | ---------------------------- |
| 第一次握手 | 客户端 | 服务端 | SYN=1, seq=x                 |
| 第二次握手 | 服务端 | 客户端 | SYN=1, ACK=1, seq=y, ack=x+1 |
| 第三次握手 | 客户端 | 服务端 | ACK=1, seq=x+1, ack=y+1      |

TCP连接建立过程又被称为三次握手过程：
- 三次握手中，前两次握手SYN标识位都为1；
- 只要之前接收到对方的消息，ACK就要置为1；
- 序列号指的是本身自己所发送的消息的序列，和对方无关，而确认号指的是希望对方下一次发送的消息序列。
- 第一次握手和第二次握手不能够携带数据，但是会额外占用一个编号
- 第三次握手可以携带数据，不会额外占用编号
### 关闭连接

![[Pasted image 20260625185313.png]]
![[2025-12-08_090102.svg]]

| 步骤 | 发送方 | 接收方 | 关键标志位与序号 |
| ---- | ------ | ------ | ---------------- |
| 第一次挥手 | 客户端 | 服务端 | FIN=1, seq=u |
| 第二次挥手 | 服务端 | 客户端 | ACK=1, seq=v, ack=u+1 |
| 第三次挥手 | 服务端 | 客户端 | FIN=1, ACK=1, seq=w, ack=u+1 |
| 第四次挥手 | 客户端 | 服务端 | ACK=1, seq=u+1, ack=w+1 |

经过四次挥手，双方都确定了对方的数据已经发送完成，并且做好了关闭连接的准备

TCP连接的关闭依然需要一定时间，服务器中TCP连接的关闭是在接收到客户端的第四次挥手消息之后。而客户端中TCP连接的关闭是在接收到服务器的第三次挥手信息后再等上2MSL

MSL：最大报文生存时间

第一次挥手和第三次挥手会额外占用编号，第二次挥手和第四次挥手不会

### 可靠数据传输

- TCP在IP层提供的不可靠服务基础上实现可靠数据传输服务
- 流水线机制
- [[确认机制#累积确认|累积确认]]
- 单一重传定时器
- 触发重传事件：超时，收到重复ACK

## 机制


[[快速重传机制]]

[[CS计算机系统/计算机网络/网络体系结构/传输层/流量控制]]

[[拥塞控制]]

### 确认机制


- TCP首部的确认号是期望收到对方的下一个报文段的数据的第一个字节的序号
- TCP默认使用[[确认机制#累积确认|累积确认]]，即TCP只确认数据流中至第一个丢失字节为止的字节


## 性能

### TCP吞吐率

TCP吞吐率throughput：给定拥塞窗口大小和RTT
- 假定发生超时时，COngWin=W，吞吐率为$\frac{W}{RTT}$
- 超时后CongWin=W/2，吞吐率为$\frac{W}{2RTT}$
- TCP平均吞吐率为$\frac{0.75W}{RTT}$

### TCP公平性

如果K个TCP会话共享相同的瓶颈带宽R，那么每个会话的平均速率为$\frac{R}{K}$，TCP具有公平性
- UDP不具备公平性
- 并发TCP不具备公平性


## 实现

### TCP RTT和超时

根据RTT设定时器的超时时间，通过SampleRTT方式估计RTT大小
- SampleRTT：测量段发出到收到ACK时间，忽略重传
- EstimatedRTT：测量多个SampleRTT，使用指数加权移动平均方法得到的估计值
	- $EstimatedRTT=(1-\alpha)\cdot EstimatedRTT+\alpha\cdot SampleRTT$
	- 典型值：0.125
- 定时器超时时间：EstimatedRTT+安全边界，边界大小根据变化程度改变
	- RTT变化值$DevRTT=(1-\beta)\cdot DevRTT+\beta\cdot \lvert{SampleRTT-EstimatedRTT}\rvert$
	- 经典值：0.25
	- $TimeoutInterval=EstimatedRTT+4\cdot DevRTT$

### TCP发送方事件

从应用层收到数据
1. 创建Segment
2. 序列号是Segment第一个字节的编号
3. 开启计时器
4. 设置超时时间TimeOutInterval

超时
1. 重传引起超时的Segment
2. 重启定时器

收到ACK
- 如果确认此前未确认的Segment，更新SendBase
- 如果窗口中还有违背确认的分组，重新启动定时器

```c++
NextSeqNum = InitialSeqNum;
SendBase = InitialSeqNum;

while(true){
	switch(event){
	case 数据已被收到从上层应用:
		create_tcp_seg(NextSeqNum,data);// 创建 TCP段
		if(timer.isStop()) timer.start(TimeOutInterval);
		udt_send(data);
		NextSeqNum+=length(data);
		break;
	case 时间超时:
		rcv_send(NAK(minSeqNum));
		timer = new timer();
		break;
	case 已收到ACK(y):
		if(y<=SendBase) break;
		SendBase = y;
		if(NAK != nullptr)timer.start(TimeOutInterval);
		break;
	}
}
```

### TCP接收方方事件

| 接收端事件                        | TCP接收活动                               |
| ---------------------------- | ------------------------------------- |
| 到达期望序列号按序段<br>且之前的期望序列号已经ACK | 延迟ACK，等待下一个段500ms。<br>如果没有下一个段，则发送ACK |
| 到达期望序列号按序段<br>其中一个段等待ACK确认   | 立刻发送累积ACK                             |
| 到达乱序段<br>检测到有间隙              | 立即发送重复ACK，指示期望得到的段                    |
### 连接管理

建立连接：初始化序列号、缓存和流量控制信息
- 客户端Client：连接发起者

```c++
Socket clientSocket = new Socket("hostname","port number"); 
```

- 服务端Server：等待客户连接请求
```c++
Socket connectionSocket = welcomeSocket.accept(); 
```

三次握手

1. 客户端主机发送TCP SYN段给服务端：没有数据，指定初始序列号
2. 服务端收到SYN，响应SYNACK段：服务器分配缓存，指定服务器初始序列号
3. 客户端收到SYNACK段，响应ACK段：可包含数据

![[2025-11-24_085750.svg]]




关闭连接：释放资源

```c++
clientSocket.close();
```

1. 客户端向服务器发送TCP FIN控制段
2. 服务器收到FIN，回复ACK，关闭连接，发送FIN
3. 客户端收到FIN，回复ACK：进入等待，如果收到FIN则重新发送ACK
4. 服务器收到ACK：关闭连接

![[2025-12-08_090102.svg]]



