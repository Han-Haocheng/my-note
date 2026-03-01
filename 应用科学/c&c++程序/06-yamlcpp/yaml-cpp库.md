## 命名空间
- `namespace YAML`

## 头文件
- `#include <yaml/yaml.h>`

## 全局变量
- （无）

## 全局函数
- `Node Load(std::string yml_str)`：字符串转yaml节点
- `std::string Dump(Node node)`：yaml节点转字符串
- `Node LoadFile(std::string filename);`：从文件获取yaml节点

## 枚举
- **Type - yaml类型**
  - `Null`

## 类

### iterator

`iterator`：yaml迭代器

#### 成员函数
`iterator_value operator*()`
- 参数：无
- 返回：迭代器所指向的值

`iterator operator++()`
- 参数：无
- 返回：下一个节点
