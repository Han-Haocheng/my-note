### uniq

```bash
用法：uniq [选项]... [输入文件 [输出文件]]  
从 <输入文件>（或标准输入）中过滤内容相同的相邻的行，  
并写到 <输出文件>（或标准输出）。  
  
不带选项时，内容相同的行将仅输出一次。  
  
长选项的必选参数对于短选项也是必选的。  
 -c, --count  
        在每行之前加上该行的重复次数作为前缀  
 -d, --repeated  
        只输出重复的行，每组重复的行输出一次  
 -D  
        输出所有重复的行  
     --all-repeated[=METHOD]  
        like -D, but allow separating groups with an empty line;  
        METHOD={none(default),prepend,separate}  
 -f, --skip-fields=N  
        avoid comparing the first N fields  
     --group[=METHOD]  
        show all items, separating groups with an empty line;  
        METHOD={separate(default),prepend,append,both}  
 -i, --ignore-case  
        比较时忽略大小写  
 -s, --skip-chars=N  
        不要比较前 N 个字符  
 -u, --unique  
        只输出不重复（内容唯一）的行  
 -z, --zero-terminated  
        以 NUL 空字符而非换行符作为行分隔符  
 -w, --check-chars=N  
        compare no more than N characters in lines  
     --help  
        display this help and exit  
     --version  
        output version information and exit  
  
字段指的是空白字符（通常是空格和/或制表符）的序列，后跟非空白字符的序列。  
程序将先跳过字段 (--skip-fields)，后跳过字符 (--skip-chars)。  
  
除非重复的行是相邻的，否则 "uniq" 将无法检测到它们。  
您可能需要事先对输入进行排序，或使用 "sort -u" 而无需接着使用 "uniq"。
```
