# Node
`Node`：表示 YAML 文档中节点的核心类

## 命名空间
- `namespace YAML`

## 头文件

## 成员函数

### 构造函数和析构函数

- `Node()`：默认构造函数。
- `~Node()`：析构函数。

### 类型检查函数

- `bool IsScalar() const`：检查节点是否是标量（即字符串、数字等）
- `bool IsSequence() const`：检查节点是否是序列（即列表）
- `bool IsMap() const`：检查节点是否是映射（即字典）
- `bool IsNull()const`：检查节点是否是空
- `bool IsDefined()const`：检查节点是否被定义

### 类型转换函数

- `std::string as<std::string>() const`：将节点转换为字符串。
- `T as() const`：将节点转换为指定类型 `T`（`T` 必须是支持 `yaml-cpp` 转换的类型）。

### 访问器

- `Node operator](const%20Key& key.md)const`：当节点是映射时，通过键来访问子节点

### 数据修改

- `void operator=(const Node& rhs)`：赋值操作符。
- `void SetStyle(EmitterStyle style)`：设置序列或映射的样式。

### 迭代器

- `iterator begin()`：返回一个迭代器到序列或映射的开始。
- `iterator end()`：返回一个迭代器到序列或映射的结束。
