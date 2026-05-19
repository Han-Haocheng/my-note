# SQL语言

**SQL**：结构化查询语言


## 数据定义

### 创建表

```MYSQL
CREATE TABLE <table_name> (
	[<field_name> <CHAR|[INTEGER|INT]|FLOAT|DOUBLE> [PRIMARY KEY],...]
);
```
参数
- `<table_name>`：创建表的表名
- `[<field_name> <CHAR|[INTEGER|INT]|FLOAT|DOUBLE> [PRIMARY KEY],...]`：表中所定义的字段
	- `<field_name>`：字段名
	- `<CHAR|[INTEGER|INT]|FLOAT|DOUBLE>`：字段类型
	- `[PRIMARY KEY]`：是否是主键

### 删除表

删除表：删除表结构和全部记录

```MYSQL
DROP TABLE <table_name>;
```

### 修改表结构
#### 增加字段、索引
```MYSQL
ALTER TABLE <table_name> ADD 
```
#### 修改字段类型、宽度和字段有效规则
```MYSQL
ALTER TABLE <table_name> ALTER
# 修改字段名
ALTER TABLE <table_name> RENAME COLUMN
# 删除字段
ALTER TABLE <table_name> DROP COLUMN
```

## 数据操纵

### 更新字段内容

**记录更新**：对指定表中满足条件的记录，用指定表达式的内容更新指定字段

```MYSQL
UPDATE <table_name> SET `field_name`=<new_value>
[WHERE <conditions>]
```

### 插入记录

**记录插入**：在指定表中插入记录，以指定内容列表中的内容为字段内容

```MYSQL
INSERT INTO <table_name> (`field_1`,`field_2`)
VALUES (<value>,<val>)
```


>[!warning]+ 注意：插入的类型为时间时，需要用 `#`作为边界符，而不是`"`

### 删除记录

**删除记录**：删除表中符合条件的记录

```mysql 
DELETE FROM <table_name>
[WHERE <conditions>]
```

## 数据查询

```MYSQL
SELECT `field_1`,...
[INTO <target_table>]
FROM <table_name>
[WHERE <conditions>]
[ORDER BY <field_name> [ASC|DESC]]
[GROUP BY <field_name> [HAVING <conditions>]]
```

参数
- `[INTO <target_table>]`：将查询结果输出到指定表中
- `[ORDER BY <field_name> [ASC|DESC]]`：按指定字段排序
	- `<field_name>`：字段名
	- `[[ASC]|<DESC>]`：升序或降序
		- `[ASC]`：默认升序，可不写
		- `<DESC>`：降序必须写
- `[GROUP BY <field_name> [ASC|DESC] [HAVING <conditions>]]`：按指定字段分组
	- `<field_name>`：字段名

	- `[HAVING <conditions>]`：设置分组条件
		- `<conditions>`：条件

## 数据控制



## 内置函数

### 聚合函数

**聚合函数**：只能作为 `HAVING`中的条件

```mysql
COUNT(<field_name>)
```

```mysql
SUM(<field_name>)
```

```mysql
AVG(<field_name>)
```

```mysql
MIN(<field_name>)
```

```mysql
MAX(<field_name>)
```
