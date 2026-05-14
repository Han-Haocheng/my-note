# C++ `std::map` 笔记

## 概述
`std::map` 是 C++ 标准库中的关联容器，提供键值对存储，基于红黑树实现。特性：
- 键唯一且有序
- 插入/删除/查找时间复杂度：O(log n)

## 成员类型

| 类型               | 定义                       |
| ---------------- | ------------------------ |
| `key_type`       | 键的类型 `Key`               |
| `mapped_type`    | 值的类型 `T`                 |
| `value_type`     | 键值对 `pair<const Key, T>` |
| `size_type`      | 无符号整数类型                  |
| `iterator`       | 双向迭代器                    |
| `const_iterator` | 常量双向迭代器                  |

## 成员函数

### 构造函数


默认构造空map

```cpp
map()
```


用范围元素构造

```cpp
map(InputIt first, InputIt last)
```

拷贝构造

```cpp
map(const map& other)
```



 方法                                  参数        说明        异常               

                            -           无                
 迭代器范围        可能抛出 `bad_alloc` 
             另一个map对象        可能抛出 `bad_alloc` 



### 容量操作
 方法          返回类型     说明                 异常 


 `empty()`     `bool`       判断是否为空         无   
 `size()`      `size_type`  返回元素数量         无   
 `max_size()`  `size_type`  返回可能的最大元素数  无   

### 元素访问
 方法            参数          返回类型            说明             异常               
 ------------  ----------  --------------  -------------  ---------------- 
 `operator[]`  `key_type`  `mapped_type&`  访问或插入元素（值初始化）  可能抛出 `bad_alloc` 
 `at(key)`     `key_type`  `mapped_type&`  访问元素（键必须存在）    `out_of_range`   

### 修改器

 方法                           参数      返回类型                    说明              异常               
 ---------------------------  ------  ----------------------  --------------  ---------------- 
 `insert(const value_type&)`  键值对     `pair<iterator, bool>`  插入元素（已存在则失败）    可能抛出 `bad_alloc` 
 `emplace(Args&&...)`         构造参数    `pair<iterator, bool>`  原位构造插入          可能抛出 `bad_alloc` 
 `erase(iterator)`            迭代器位置   `iterator`              删除指定元素          无                
 `erase(const Key&)`          键       `size_type`             删除键对应的元素        无                
 `clear()`                    -       `void`                  清空所有元素          无                
 `merge(map& source)`         源map对象  `void`                  合并两个map（C++17）  可能抛出异常           

### 查找操作

 方法                 参数        返回类型             说明                           异常 
----------------------------------------------------------------------------------------
 `find(const Key&)`   键          `iterator`         查找元素，返回迭代器           无   
 `count(const Key&)`  键          `size_type`        统计键出现次数（0或1）         无   
 `lower_bound(key)`   键          `iterator`         返回第一个不小于key的迭代器     无   
 `upper_bound(key)`   键          `iterator`         返回第一个大于key的迭代器       无   
 `equal_range(key)`   键          `pair<iterator>`   返回匹配键的范围               无   

### 观察器
 方法             返回类型                说明                   异常 
--------------------------------------------------------------------
 `key_comp()`     `key_compare`          获取键比较对象         无   
 `value_comp()`   `value_compare`        获取值比较对象         无   

## 非成员函数
 函数                   说明                       异常                  
------------------------------------------------------------------------
 `operator==`           判断相等                   可能抛出元素比较异常 
 `std::swap(map1, map2)`  交换两个map内容（C++11）  无                   

## 异常总结
- **内存分配失败**：`bad_alloc`（`insert`/`emplace`/operator[]）
- **越界访问**：`out_of_range`（`at()`）
- **用户定义操作**：比较/复制操作可能抛出异常

## 示例代码

```cpp
#include <map>
#include <string>

int main() {
    std::map<int, std::string> m;
    
    // 插入元素
    m.insert({1, "one"});
    m.emplace(2, "two");
    
    // 访问元素
    m[3] = "three";
    try {
        auto val = m.at(4); // 抛出异常
    } catch(const std::out_of_range& e) {}
    
    // 遍历
    for(const auto& [key, value] : m) {
        // 处理键值对
    }
    
    return 0;
}
