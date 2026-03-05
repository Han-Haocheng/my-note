# 简介
epoll 是 Linux 上用于事件驱动编程的一种机制，通常用于高性能网络编程。它可以用来监视文件描述符（file descriptors）上的事件，例如套接字（sockets），文件，或管道，以便在这些文件描述符上发生事件时进行相应的处理。
# 头文件

`#include <sys/epoll.h>`

# 宏
- `EPOLLIN` ： 表示对应的文件描述符可以读（包括对端SOCKET正常关闭）
- `EPOLLOUT`： 表示对应的文件描述符可以写
- `EPOLLPRI`： 表示对应的文件描述符有紧急的数据可读（这里应该表示有带外数据到来）
- `EPOLLERR`： 表示对应的文件描述符发生错误
- `EPOLLHUP`： 表示对应的文件描述符被挂断
- `EPOLLET`： 将 EPOLL设为边缘触发(Edge Triggered)模式（默认为水平触发），这是相对于水平触发(Level Triggered)来说的。
- `EPOLLONESHOT`： 只监听一次事件，当监听完这次事件之后，如果还需要继续监听这个socket的话，需要再次把这个socket加入到EPOLL队列里

## 边沿触发与水平触发
**水平触发(level-triggered)**
- socket接收缓冲区不为空 有数据可读 读事件一直触发  
- socket发送缓冲区不满 可以继续写入数据 写事件一直触发   

**边沿触发(edge-triggered)**
- socket的接收缓冲区状态变化时触发读事件，即空的接收缓冲区刚接收到数据时触发读事件
- socket的发送缓冲区状态变化时触发写事件，即满的缓冲区刚空出空间时触发读事件

# 结构体
## epoll数据
```c
typedef union epoll_data{
  void *ptr;
  int fd;
  uint32_t u32;
  uint64_t u64;
} epoll_data_t;
```
- 描述：用于保存任意数据
## epoll事件
```C
struct epoll_event{
  uint32_t events;  /* Epoll events */
  epoll_data_t data;    /* User data variable */
}
```
- 参数
  - events：epoll事件
  - data：用户数据

# 函数
## 创建epoll实例
`int epoll_create(size_t size);`
- 描述：创建一个epoll的实例
- 参数：size: 要关联的文件数量

返回 - epoll实例的句柄（句柄要用close函数关闭）
## 添加epoll事件
`int epoll_ctl(int epfd, int op, int fd, epoll_event* event);`
- 作用：修改一个epoll的模式
- 参数
  - epfd：epoll句柄
  - op：执行的操作
    - `EPOLL_CTL_ADD` ：添加事件操作
    - `EPOLL_CTL_MOD` ：修改事件操作
    - `EPOLL_CTL_MOD` ：删除事件操作
  - fd：epoll事件要操作的网络读写句柄（通过pipe函数获取）
  - event：要操作的通知
    - `EPOLLIN`：输入模式
    - `EPOLLOUT`：输出模式
    - `EPOLLET`：使用边缘触发模式（在事件发生时只触发一次，而不会重复通知）

- 返回：函数运行状态
  - 0：成功
  - -1：失败
- 错误：存放于`errno`中
## 等待epoll事件
`int epoll_wait`
# 示例
```c
#define MAX_EVENTS 10
int main(int argc, char**argv){
  struct epoll_event ev;
  struct events[MAX_EVENTS];
  int listen_sock;
  int conn_sock;
  int nfds;
  int epollfd;
  
  /* 设置监听socket, 'listen_sock',
    (socket(), bind(), listen()) omitted */
  
  // 创建epoll实例
  epollfd = epoll_create1(0);
  if (epollfd == -1) {
     perror("epoll_create1");
     exit(EXIT_FAILURE);
  }
  
  // 将监听的端口的socket对应的文件描述符添加到epoll事件列表中
  ev.events = EPOLLIN;
  ev.data.fd = listen_sock;
  if (epoll_ctl(epollfd, EPOLL_CTL_ADD, listen_sock, &ev) == -1) {
     perror("epoll_ctl: listen_sock");
     exit(EXIT_FAILURE);
  }
  
  for (;;) {
     // epoll_wait 阻塞线程，等待事件发生
     nfds = epoll_wait(epollfd, events, MAX_EVENTS, -1);
     if (nfds == -1) {
         perror("epoll_wait");
         exit(EXIT_FAILURE);
     }
  
     for (n = 0; n < nfds; ++n) {
         if (events[n].data.fd == listen_sock) {
             // 新建的连接
             conn_sock = accept(listen_sock,
                                (struct sockaddr *) &addr, &addrlen);
             // accept 返回新建连接的文件描述符
             if (conn_sock == -1) {
                 perror("accept");
                 exit(EXIT_FAILURE);
             }
             setnonblocking(conn_sock);
             // setnotblocking 将该文件描述符置为非阻塞状态
  
             ev.events = EPOLLIN | EPOLLET;
             ev.data.fd = conn_sock;
             // 将该文件描述符添加到epoll事件监听的列表中，使用ET模式
             if (epoll_ctl(epollfd, EPOLL_CTL_ADD, conn_sock,
                         &ev) == -1)
                 perror("epoll_ctl: conn_sock");
                 exit(EXIT_FAILURE);
             }
         } else {
             // 使用已监听的文件描述符中的数据
             do_use_fd(events[n].data.fd);
         }
     }
  }
}
```

