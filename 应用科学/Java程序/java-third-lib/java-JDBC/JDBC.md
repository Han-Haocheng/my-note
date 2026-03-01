JDBC
2023年9月17日
9:33

1.  加载驱动类
Class.forName("com.msyql.cj.jdbc.Dirver");
2.  获取数据库链接
class DirverManager

Connection getConnection(String url,String user,String pws);

输入

url - 链接的数据库的地址

user - 用户名

pws - 密码

输出

Connection 数据库链接

3.  获取预编译sql语句平台
class Connection

PreparedStatement preparedStatement(String sql);

输入

sql - sql语句

输出

PreparedStatement 预编译语句
4.  设置sql语句的参数并执行
class PreparedStatement
- 设置字符串
void setString(int idx, String avg)

输入

idx - 参数在预编译语句中'?'的索引

avg - 参数

输出

void - 无
- 设置整数
void setInt(int idx, String avg)

输入

idx - 参数在预编译语句中'?'的索引

avg - 参数

输出

void - 无
- 设置浮点数
void setDouble(int idx, String avg)

输入

idx - 参数在预编译语句中'?'的索引

avg - 参数

输出

void - 无

-------------------------------------------
- 执行语句
boolean execute()

输入

无

输出

boolean - 是否执行成功
- 执行查询语句
ResultSet executeQuery()

输入

无

输出

ResultSet - 查询的结果集合
- 执行更新语句
int executeUpdate()

输入

无

输出

int - 变化的数据量
- 解析结果
class ResultSet
- 将指针指向下一条数据
boolean next()

输入

无

输出

boolean -是否指向了下一条数据

----------------------------------
- 获取字段对应字符串
String getString(String field)

输入

field - 字段

输出

字符串
- 获取字段对应浮点数
double getDouble(String field)

输入

field - 字段

输出

浮点数

- 获取字段对应整数
int getInt(String field)

输入

field - 字段

输出

整数
- 释放资源
rs.close();

ps.close();

conn.close();
