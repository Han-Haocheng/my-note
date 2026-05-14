# cat

```bash
用法：cat [选项]... [文件]...  
连接一个或多个 <文件> 并输出到标准输出。  
  
如果没有指定 <文件>，或者 <文件> 为 "-"，则从标准输入读取。  
 -A, --show-all           等价于 -vET  
 -b, --number-nonblank    对非空输出行编号，使 -n 失效  
 -e                       等价于 -vE  
 -E, --show-ends          在每行行末显示 $ 或 ^M$  
 -n, --number             对输出的所有行编号  
 -s, --squeeze-blank      不重复输出空行  
 -t                       等价于 -vT  
 -T, --show-tabs          将 TAB 显示为 ^I  
 -u                       （被忽略）  
 -v, --show-nonprinting   使用 ^ 和 M- 表示法，LFD 和 TAB 字符除外  
     --help  
        display this help and exit  
     --version  
        output version information and exit  
  
示例：  
 cat f - g  先输出 f 的内容，然后输出标准输入的内容，最后输出 g 的内容。  
 cat        将标准输入的内容复制到标准输出。
```