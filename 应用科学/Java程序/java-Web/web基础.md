B/S架构：浏览器/服务器
- 浏览器
- 客户端零维护
- 与操作系统平台的关系最小化
- 在响应速度和安全性上需要花费更多设计成本
C/S架构：客户端/服务器
- 需要专门的客户端应用
- 客户端需要单独维护和升级
- 对客户端操作系统一般有限制
- 能充分发挥客户端处理能力，响应速度快
B/S架构工作原理
1.  用户浏览器
2.  发送客户端的请求信息
3.  应用服务器端
4.  访问数据库服务器
5.  数据返回到应用服务器
6.  返回服务器端检索的信息
统一资源定位符
用于完整地描述互联网资源的地址

==http== :// ==localhost==:==8080== / ==news/index.html==

==协议部分==://==主机IP地址==:==端口号== /==项目资源地址==
基于TCP协议之上的请求-响应协议
GET请求方式
/test/index.jsp?name1=value1&name2=value

特点
- 传送数据量较小
- 传输数据在URL可见
- 安全性低
- 能被缓存

POST请求方式
POST /test/index.jsp HTTP/1.1

Host: bdqn.cn

name1=value1&name2=value2

特点
- 传送数据量无限制
- 传输数据在URL不可见
- 安全性高
- 不能被缓存

HTTP状态码
服务器使用请求状态码和请求消息表示响应状态
| 状态码 | 消息                  | 描述                          |
|--------|-----------------------|-------------------------------|
| 200    | OK                    | 请求成功                      |
| 302    | Found                 | 所请求的页面已经转移至新的url |
| 400    | Bad Request           | 服务器未能理解请求            |
| 404    | Not Found             | 服务器无法找到被请求的页面    |
| 500    | Internet Server Error | 服务器错误                    |
project
/src - Java源码

/entity

/dao

/service

/sevlet

/web - 网站结构

/js - JavaScript文件

/images - 图片文件

/css - 样式表文件

/WEB-INF - 网站隐藏信息

/lib - 库

/templates - 模板

/web.xml - 网站配置文件

输出对象 out
方法
在页面中出入String的内容。
void print(String out)

输入 - out - 要输出的内容

返回 - void

会话对象 session
作用范围 - 一次会话中
会话技术
会话跟踪机制
- 一种服务器端的机制
- 用户第一次请求服务器时创建会话，并返回sessionId
- 后续请求携带该sessionId，携带同一sessionId的请求被认为处于同一会话中
使用session内置对象描述一次会话
- 一次会话包含多次请求和响应
会话与窗口的关系
- 每个session对象都与一个浏览器窗口对应
- 重新开启一个浏览器窗口，可以重新创建一个session对象
- 通过超链接打开的新窗口，新窗口的session与其父窗口的session相同
会话销毁
调用session对象的invalidate()方法，可以销毁session对象
会话超时
1.  通过setMaxInactiveInterval(int interval)方法设置session有效时长，单位秒
session.setMaxInactiveInterval(15\*60);
2.  通过项目配置文件设置session有效时长，单位是分钟
\<session-config\>

\<session-timeout\>10\</session-timeout\>

\</session-config\>
3.  通过Tomcat服务器设置session有效时长，单位是分钟。修改Tomcat目录下的/conf/web.xml文件
\<session-config\>

\<session-timeout\>30\</session-timeout\>

\</session-config\>

函数
获取sessionid
getId()

输入

无

返回

String - 会话的id
返回session对象被创建的时间，以毫秒为单位
getCreationTime()

输入

无

返回

long - 会话创建的时间（毫秒）

设定session的非活动时间，以秒为单位
setMaxInactiveInterval(int interval)

输入

int interval - 间隔时间（秒）

输出

无

获取session的有效非活动时间，以秒为单位
getMaxInactiveInterval()

输入

无

输出

int - 有效非活动时间（秒）
设置session对象失效
invalidate()

输入

无

输出

int - 有效非活动时间（秒）

以key/value的形式将对象保存到session中
setAttribute(String key, Object value)

输入

key - 要设置的键

value - 要设置的值

输出

无

通过key获取session中保存的对象
getAttribute(String key):

输入

key - 属性的键

输出

Object - 属性的值
从session中删除指定key对应的对象
removeAttribute(String key)

输入

key - 键

输出

无
