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

# 数据定义语句

## 创建数据库

```mysql
CREATE { DATABASE | SCHEMA } [IF NOT EXISTS] <`db_name`> 
	[[DEFAULT] CHARACTER SET <charset>] 
	[[DEFAULT] COLLATE [=] <collate_>];
```

### 查看数据库


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

### 修改数据表


```sql
ALTER TABLE tbl_name
    [alter_option [, alter_option] ...]
    [partition_options];
```

####  列操作

列操作：针对表中列的添加、修改、删除和重命名。

**新增列**

- 

```mysql
-- 添加单列，可指定位置
ADD [COLUMN] col_name column_definition [FIRST | AFTER col_name]

-- 添加多列
ADD [COLUMN] (col_name column_definition,...) 
```


**修改列**

```mysql
-- **重命名**并修改列定义。 
CHANGE [COLUMN] old_col_name new_col_name column_definition [FIRST | AFTER col_name]

-- 仅修改列定义或位置，**不重命名**
MODIFY [COLUMN] col_name column_definition [FIRST | AFTER col_name]
```

**列属性**：设置默认值、可见性或删除默认值。
```mysql
ALTER [COLUMN] col_name { SET DEFAULT {literal | (expr)} | SET {VISIBLE | INVISIBLE} | DROP DEFAULT }
```

**重命名列**：仅重命名列。
```mysql
RENAME COLUMN old_col_name TO new_col_name
```

**删除列**：删除指定列。

```mysql
DROP [COLUMN] col_name
```

#### 索引与约束操作

 索引与约束操作：针对主键、索引、外键和检查约束的管理。

| 操作类型     | 语法格式                                                                                                   | 说明                    |
| :------- | :----------------------------------------------------------------------------------------------------- | :-------------------- |
| **主键**   | `ADD [CONSTRAINT [symbol]] PRIMARY KEY [index_type] ({col_name [(length)]\| (expr)} [ASC\| DESC],...)` | 添加主键。                 |
|          | `DROP PRIMARY KEY`                                                                                     | 删除主键。                 |
| **唯一索引** | `ADD [CONSTRAINT [symbol]] UNIQUE [INDEX \| KEY] [index_name] ...`                                     | 添加唯一约束/索引。            |
| **普通索引** | `ADD {INDEX \| KEY} [index_name] [index_type] ({col_name [(length)]\| (expr)} [ASC\| DESC],...)`       | 添加普通索引。               |
| **特殊索引** | `ADD {FULLTEXT \| SPATIAL} [INDEX \| KEY] ...`                                                         | 添加全文索引或空间索引。          |
| **外键**   | `ADD [CONSTRAINT [symbol]] FOREIGN KEY [index_name] ...`                                               | 添加外键约束。               |
|          | `DROP FOREIGN KEY fk_symbol`                                                                           | 删除外键。                 |
| **检查约束** | `ADD [CONSTRAINT [symbol]] CHECK (expr) [[NOT] ENFORCED]`                                              | 添加 CHECK 约束。          |
|          | `DROP {CHECK \| CONSTRAINT} symbol`                                                                    | 删除约束。                 |
|          | `ALTER {CHECK \| CONSTRAINT} symbol [NOT] ENFORCED`                                                    | 启用/禁用约束检查。            |
| **索引管理** | `DROP {INDEX \| KEY} index_name`                                                                       | 删除索引。                 |
|          | `RENAME {INDEX \| KEY} old_index_name TO new_index_name`                                               | 重命名索引。                |
|          | `ALTER INDEX index_name {VISIBLE \| INVISIBLE}`                                                        | 设置索引可见性。              |
| **索引开关** | `{DISABLE \| ENABLE} KEYS`                                                                             | 禁用或启用索引更新（MyISAM 特有）。 |

#### 表属性与元数据

表属性与元数据：修改表名、表空间、字符集及其他表级选项。

| 操作类型 | 语法格式 | 说明 |
| :--- | :--- | :--- |
| **重命名表** | `RENAME [TO \| AS] new_tbl_name` | 修改表名。 |
| **字符集** | `[DEFAULT] CHARACTER SET [=] charset_name [COLLATE [=] collation_name]` | 设置默认字符集。 |
| | `CONVERT TO CHARACTER SET charset_name [COLLATE collation_name]` | 转换表中现有数据的字符集。 |
| **表空间** | `{DISCARD \| IMPORT} TABLESPACE` | 丢弃或导入表空间（用于传输表空间）。 |
| **表选项** | `table_options` | 修改引擎、自增值、注释等（详见后文“表选项定义”）。 |
| **其他** | `FORCE` | 强制重建表（通常用于修复）。 |
| | `ORDER BY col_name [, col_name] ...` | 对表进行排序存储（不影响查询顺序）。 |
| | `{WITHOUT \| WITH} VALIDATION` | 配合分区操作使用。 |

#### 分区操作

分区操作：针对分区表的管理操作。
```sql
partition_option: {
    ADD PARTITION (partition_definition)
  | DROP PARTITION partition_names
  | DISCARD PARTITION {partition_names | ALL} TABLESPACE
  | IMPORT PARTITION {partition_names | ALL} TABLESPACE
  | TRUNCATE PARTITION {partition_names | ALL}
  | COALESCE PARTITION number
  | REORGANIZE PARTITION partition_names INTO (partition_definitions)
  | EXCHANGE PARTITION partition_name WITH TABLE tbl_name [{WITH | WITHOUT} VALIDATION]
  | ANALYZE PARTITION {partition_names | ALL}
  | CHECK PARTITION {partition_names | ALL}
  | OPTIMIZE PARTITION {partition_names | ALL}
  | REBUILD PARTITION {partition_names | ALL}
  | REPAIR PARTITION {partition_names | ALL}
  | REMOVE PARTITIONING
}
```

#### 执行控制

执行控制：控制 ALTER 语句执行的算法和并发级别。

| 选项 | 语法 | 说明 |
| :--- | :--- | :--- |
| **算法** | `ALGORITHM [=] {DEFAULT \| INSTANT \| INPLACE \| COPY}` | 指定执行算法（Instant 最快，Copy 最慢）。 |
| **锁级别** | `LOCK [=] {DEFAULT \| NONE \| SHARED \| EXCLUSIVE}` | 指定并发控制锁级别（None 并发最高，Exclusive 阻塞最大）。 |

### 七、 关键定义细节

#### 1. 索引部分定义 ( `key_part` )
```sql
key_part: {col_name [(length)] | (expr)} [ASC | DESC]
```
*支持指定列名（带长度）或表达式，并支持排序方向。*
#### 2. 索引类型 ( `index_type` )
```sql
index_type: USING {BTREE | HASH}
```
#### 3. 索引选项 ( `index_option` )
```sql
index_option: {
    KEY_BLOCK_SIZE [=] value
  | index_type
  | WITH PARSER parser_name
  | COMMENT 'string'
  | {VISIBLE | INVISIBLE}
}
```
#### 4. 表选项定义 ( `table_options` )
用于定义表的物理属性和引擎行为。
```sql
table_option: {
    AUTOEXTEND_SIZE [=] value
  | AUTO_INCREMENT [=] value
  | AVG_ROW_LENGTH [=] value
  | [DEFAULT] CHARACTER SET [=] charset_name
  | CHECKSUM [=] {0 | 1}
  | [DEFAULT] COLLATE [=] collation_name
  | COMMENT [=] 'string'
  | COMPRESSION [=] {'ZLIB' | 'LZ4' | 'NONE'}
  | CONNECTION [=] 'connect_string'
  | {DATA | INDEX} DIRECTORY [=] 'absolute path to directory'
  | DELAY_KEY_WRITE [=] {0 | 1}
  | ENCRYPTION [=] {'Y' | 'N'}
  | ENGINE [=] engine_name
  | ENGINE_ATTRIBUTE [=] 'string'
  | INSERT_METHOD [=] { NO | FIRST | LAST }
  | KEY_BLOCK_SIZE [=] value
  | MAX_ROWS [=] value
  | MIN_ROWS [=] value
  | PACK_KEYS [=] {0 | 1 | DEFAULT}
  | PASSWORD [=] 'string'
  | ROW_FORMAT [=] {DEFAULT | DYNAMIC | FIXED | COMPRESSED | REDUNDANT | COMPACT}
  | SECONDARY_ENGINE_ATTRIBUTE [=] 'string'
  | STATS_AUTO_RECALC [=] {DEFAULT | 0 | 1}
  | STATS_PERSISTENT [=] {DEFAULT | 0 | 1}
  | STATS_SAMPLE_PAGES [=] value
  | TABLESPACE tablespace_name [STORAGE {DISK | MEMORY}]
  | UNION [=] (tbl_name[,tbl_name]...)
}
```

---
# 数据操作语句



---
# 数据库管理语句

---
# 事务管理语句
