# mysql

## 数据类型

### 数值类型


TINYINT：很小整数，M 表示数值的位数，
 - 带符号的范围是-128～127，无符号的范围是 0～255。

```mysql
TINYINT[(M)] [UNSIGNED] [ZEROFILL] 
```
 - `[UNSIGNED]`指定无符号正值；
 - `[ZEROFILL]`填充 0 。


```
INT[(M)] 
```

## 数据定义语句


### 创建数据库

```mysql
CREATE { DATABASE | SCHEMA } [IF NOT EXISTS] <`db_name`> 
	[[DEFAULT] CHARACTER SET <charset>] 
	[[DEFAULT] COLLATE [=] <collate_>];
```


### 修改数据库

```MYSQL
ALTER { DATABASE | SCHEMA } [ db_name ] 
	[DEFAULT] CHARACTE SET [ = ] charset_name
	[DEFAULT] COLLATE [ = ] collation name;
```

### 删除数据库

```Mysql
DROP { DATABASE | SCHEMA } [ IF EXISTS ] db_name;
```

### 使用数据库

```mysql
USE <`db_name`>
```


### 展示信息

```mysql

```
### 创建数据表

```mysql
CREATE TABLE [IF NOT EXISTS] <`tb_name`>{
  <`field_name`> <type> [NOT NULL] [UNIQUE] [PRIMARY KEY] [DEFAULT <def_val>] [AUTO_INCREMENT] [REFERENCES <`tb_name`.`field`>] [COMMENT <'comment'>],
  ...
  [,[CONSTRAINT <pk_name>] PRIMARY KEY(<`field_name`>)]
  [,FOREIGN KEY(``),...]
}[ENGINE=<`engin_name`>];
```

完整性约束
- `[NOT NULL]` 非空约束
- `[UNIQUE]` 唯一约束

键
- `[PRIMARY KEY]` 主键

`DEFAULT <def_val>`



---
# 数据操作语句



---
# 数据库管理语句

---
# 事务管理语句
