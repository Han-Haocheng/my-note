# 描述
linux用于控制句柄状态的api
# 函数
```c
int fcntl(int fd,int cmd, ...);
```

参数

- fd：要操控的句柄
- cmd：要进行的操作

| 操作符             | 含义     | 参数类型 | 参数  |
| --------------- | ------ | ---- | --- |
| F_SETFL         | 进行设置标志 |      |     |
| F_GETFL         | 进行获取标志 |      |     |
| F_DUPFD         |        |      |     |
| F_DUPFD_CLOEXEC |        |      |     |
| F_SETFD         |        |      |     |
| F_SETOWN        |        |      |     |
| F_SETSIG        |        |      |     |
| F_SETLEASE      |        |      |     |
| F_NOTIFY        |        |      |     |
| F_SETPIPE_SZ    |        |      |     |
| F_GETFD         |        |      |     |
| F_GETOWN        |        |      |     |
| F_GETSIG        |        |      |     |
| F_GETLEASE      |        |      |     |
| F_GETPIPE_SZ    |        |      |     |
| F_SETLK         |        |      |     |
| F_SETLKW        |        |      |     |
| F_GETLK         |        |      |     |
| F_GETOWN_EX     |        |      |     |
| F_SETOWN_EX     |        |      |     |

返回：句柄状态
- `O_NONBLOCK`：非堵塞状态
