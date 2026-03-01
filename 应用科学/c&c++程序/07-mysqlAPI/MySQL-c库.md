MySQL-c库
2023年9月20日
8:29
初始化MySQL库
int mysql_library_init(int argc,char\*\*argv,char\*\*groups)

描述

用于在调用其他MySQL函数前初始化MySQL客户端库。在一个非多线程的环境中，可以省略调用；在多线程环境中，它是一个非线程安全函数。因此必须在启用线程前调用或使用线程锁保护。在结束调用MySQL后必须使用mysql_library_end()来释放内存。

参数

argc - 8.0版本已失效，为0

argv - 8.0版本已失效，为NULL

groups - 8.0版本已失效，为NULL

返回

int - 执行情况值，0为正常，非0为错误
结束MySQL库
void msyql(void)

描述

用于当使用完后终结MySQL库。
初始化MYSQL句柄
MYSQL\* mysql_init(MYSQL\*mysql)

描述

用于初始化MYSQL对象以用于接下来的链接。由于在非多线程的环境中，会自动调用mysql_library_init()，因此也是非线程安全的函数。当使用完成后必须调用mysql_close()来关闭句柄。

参数

mysql - 一个MYSQL句柄对象，如果为null，则生成一个新对象

返回

MYSQL\* - 初始化后的MYSQL句柄对象
关闭MYSQL句柄
void mysql_close(MYSQL\* mysql)

描述

用于关闭一个不再需要的MYSQL句柄对象

参数

msyql - 需要关闭的MYSQL句柄对象
链接MySQL数据库
MYSQL \*mysql_real_connect(

MYSQL \*mysql,

const char \*host,

const char \*user,

const char \*passwd,

const char \*db,

unsigned int port,

const char \*unix_socket,

unsigned long client_flag

)

描述

用于在host上正在运行的mysql服务器，建立一个链接，客户端程序必须在连接后才能执行其他的API函数。

参数

mysql - 初始化后的MYSQL对象句柄

host - MySQL服务器地址

user - 访问MySQL服务器的用户名

passwd - 与用户名对应的密码

db - 所要的数据库名

port - MySQL服务的端口

unix_socket - unix的接口

client_flag - 通常为0

返回

如果链接成功，则返回mysql参数，如果失败则返回null

错误

错误指向
执行sql语句
int mysql_real_query(

MYSQL\*mysql,

const char\*stmt_str,

unsigned long length

)

