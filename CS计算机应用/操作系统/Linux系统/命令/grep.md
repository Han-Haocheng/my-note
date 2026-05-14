# grep

```bash
用法：grep [选项]... 模式 [文件]...  
在每个 <文件> 中查找指定的 <模式>。  
例如：grep -i 'hello world' menu.h main.c  
<模式> 可以包含多个模式字符串，使用换行符进行分隔。  
  
模式选择与解释：  
 -E, --extended-regexp     <模式> 是扩展正则表达式  
 -F, --fixed-strings       <模式> 是字符串  
 -G, --basic-regexp        <模式> 是基本正则表达式  
 -P, --perl-regexp         <模式> 是 Perl 正则表达式  
 -e, --regexp=模式         使用指定的 <模式> 进行匹配  
 -f, --file=文件           从指定的 <文件> 中获得 <模式>  
 -i, --ignore-case         对于模式和数据，忽略大小写  
     --no-ignore-case      不要忽略大小写（默认）  
 -w, --word-regexp         仅匹配整个单词  
 -x, --line-regexp         仅匹配整行  
 -z, --null-data           数据行以 0 字节 (NUL) 结束，而非换行符  
  
杂项：  
 -s, --no-messages         不显示错误信息  
 -v, --invert-match        选中不匹配的行  
 -V, --version             显示版本信息并退出  
     --help                显示此帮助信息并退出  
  
输出控制：  
 -m, --max-count=数值      选中 <数值> 行后停止执行  
 -b, --byte-offset         输出的同时打印字节偏移量  
 -n, --line-number         输出的同时打印行号  
     --line-buffered       每行输出后排空输出缓冲区  
 -H, --with-filename       输出的同时打印文件名  
 -h, --no-filename         输出时不显示文件名前缀  
     --label=标签          使用指定 <标签> 作为标准输入文件名前缀  
 -o, --only-matching       只显示行中非空的匹配部分  
 -q, --quiet, --silent     不显示所有常规输出  
     --binary-files=类型   假定二进制文件是 <类型>；  
                           <类型> 可以是 "binary"、"text" 或 "without-match"  
 -a, --text                等价于 --binary-files=text  
 -I                        等价于 --binary-files=without-match  
 -d, --directories=动作    处理目录的方式；  
                           <动作> 可以是 "read"、"recurse" 或 "skip"  
 -D, --devices=动作        处理设备、FIFO 和套接字的方式；  
                           <动作> 可以是 "read" 或 "skip"  
 -r, --recursive           等价于 --directories=recurse  
 -R, --dereference-recursive  同上，但跟随所有符号链接  
     --include=GLOB        只查找匹配 GLOB（含通配符的文件模式）的文件  
     --exclude=GLOB        跳过匹配 GLOB 的文件  
     --exclude-from=文件   跳过匹配 <文件> 内容中任一文件模式的文件  
     --exclude-dir=GLOB    跳过匹配 GLOB 的目录  
 -L, --files-without-match  只打印没有被选中的行的 <文件> 的名称  
 -l, --files-with-matches  只打印有被选中的行的 <文件> 的名称  
 -c, --count               只打印每个 <文件> 的被选中的行的数量  
 -T, --initial-tab         使制表符对齐（如有必要）  
 -Z, --null                在 <文件> 名后打印 0 字节 (NUL)  
  
文件控制：  
 -B, --before-context=数值  打印前面 <数值> 行上下文  
 -A, --after-context=数值  打印后面 <数值> 行上下文  
 -C, --context=数值        打印前后 <数值> 行上下文  
 -数值                     等价于 --context=数值  
     --group-separator=分隔符  在带有上下文的匹配块之间打印 <分隔符>  
     --no-group-separator  不要在带有上下文的匹配块之间打印分隔符  
     --color[=何时],  
     --colour[=何时]       使用标记高亮匹配的字符串；  
                           <何时> 可以是 "always"、"never" 或 "auto"  
 -U, --binary              不要清除行尾的 CR 字符 (MSDOS/Windows)  
  
若 <文件> 为 "-"，则从标准输入读取。若没有指定 <文件>，则从标准输入  
读取，但指定了 -r 时，则递归地搜索当前的工作目录。若指定的 <文件>  
数量少于两个，则默认启用 -h 选项。如果有任意行被选中，则退出状态为 0，  
否则退出状态为 1；如果有错误发生，且未指定 -q 选项，则退出状态为 2。
```