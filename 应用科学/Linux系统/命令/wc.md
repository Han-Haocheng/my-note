### wc
```bash
用法：wc [选项]... [文件]...  
　或：wc [选项]... --files0-from=F  
打印每个 <文件> 的换行符、单词和字节计数；如果指定了多个 <文件>，  
则还会打印一个 "总计" 行。此处的 "单词" 是指由空白字符或者输入的开始  
或结束分隔的、非空的、由非空白字符构成的字符序列。  
  
如果没有指定 <文件>，或者 <文件> 为 "-"，则从标准输入读取。  
  
可使用以下选项选择输出哪些种类的计数。输出总是遵循以下顺序：  
换行符数、单词数、字符数、字节数、最长行的长度。  
 -c, --bytes  
        输出字节数  
 -m, --chars  
        输出字符数  
 -l, --lines  
        输出换行符数  
     --debug  
        indicate what line count acceleration is used  
     --files0-from=F  
        read input from the files specified by  
        NUL-terminated names in file F;  
        If F is -, read names from standard input  
 -L, --max-line-length  
        输出最长行的长度  
 -w, --words  
        输出单词数  
     --total=WHEN  
        when to print a line with total counts;  
        WHEN can be: auto, always, only, never  
     --help  
        display this help and exit  
     --version  
        output version information and exit
```