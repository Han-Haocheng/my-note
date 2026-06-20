---
tags:
  - 计算机科学/计算机网络/网络层
  - 类型/网络/协议
---

# 内部网关协议 

开放最短路径优先OSPF (Open Shortest Path First)：使用了 Dijkstra 提出的最短路径算法 SPF。采用分布式链路状态协议link state protocol，
- 克服 RIP 的缺点，在 1989 年开发出来的
- 原理简单，实现复杂
- 现在使用OSPFv2

## 特点

- 采用*洪泛法*flooding，向本自治系统中*所有路由器*发送信息
- 发送的信息是与本路由器相邻的所有路由器的*链路状态*，但这只是路由器所知道的部分信息
	- 链路状态：说明本路由器都和哪些路由器*相邻*，以及该链路的度量metric
- 当链路状态发生变化或每隔一段时间（如30分钟），路由器才用洪泛法向所有路由器发送此信息


链路状态数据库link-state database： 每个路由器最终都能建立，全网的拓扑结构图，在全网范围内是一致的，每个路由器使用链路状态数据库中的数据构造自己的路由表
- 链路状态数据库能较快地进行更新，使各个路由器能及时更新其路由表。
- 重要优点：OSPF 更新过程收敛速度快。


## 区域划分

OSPF 将自治系统划分为两种不同的区域area
- 区域边界路由器 ABR (area border router)
- 主干路由器BR (backbone router)
- 自治系统边界路由器ASBR (AS border router)


- 优点：减少了整个网络上的通信量，减少了需要维护的状态数量。
- 缺点：交换信息的种类增多了，使 OSPF 协议更加复杂了。

- 分层次划分区域的好处：使每一个区域内部交换路由信息的通信量大大减小，因而使 OSPF 协议能够用于规模很大的自治系统中。
## 分类
### 2. OSPF 的五种分组类型

问候Hello、数据库描述Database Description、链路状态请求Link State Request、链路状态更新Link State Update、链路状态确认Link State Acknowledgment


![[Pasted image 20251110085722.png]]
