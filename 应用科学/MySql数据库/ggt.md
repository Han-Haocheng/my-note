升序排序（不写为默认）
```mysql
mysql> SELECT studentNO,studentName,sex FROM tb_student ORDER BY sex;
```
降序排序
```mysql
mysql> SELECT studentNO,studentName,sex FROM tb_student ORDER BY sex DESC;
``` 

注意：当对空值进行排序时，ORDER BY子句会将该空值作为最小值来对待。

### 限制查询结果的数量
 当使用SELECT语句返回的结果集中行数很多时，为了便于用户对查向结果集进行浏览和操作，可以使用LIMIT子句来限制SELECT语句返回的行数(界限)。
 LIMIT子句的语法格式是：
```mysql
LIMIT [初始位置,] 行数
``` 

