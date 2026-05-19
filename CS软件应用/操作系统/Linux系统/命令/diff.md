# diff

```bash
用法：diff [选项]... 文件列表  
逐行比较 <文件列表> 中的文件。  
  
长选项的必选参数对于短选项也是必选的。  
     --normal                  以正常的 diff 格式输出（默认）  
 -q, --brief                   仅当文件不同时报告  
 -s, --report-identical-files  当两个文件相同时也进行报告  
 -c, -C 数字, --context[=数字]  输出 <数字> 行（默认为 3 行）复制上下文  
 -u, -U 数字, --unified[=数字]  输出 <数字> 行（默认为 3 行）统一上下文  
 -e, --ed                      以 ed 脚本格式输出  
 -n, --rcs                     以 RCS diff 格式输出  
 -y, --side-by-side            以两栏格式输出  
 -W, --width=数字              每行宽度最多 <数字> 个（默认为 130 个）字符  
     --left-column             对于相同的行只输出左栏  
     --suppress-common-lines   对于相同的行不进行输出  
  
 -p, --show-c-function         显示每个变更位于哪个 C 函数中  
 -F, --show-function-line=正则  显示匹配 <正则> 表达式的最近一行  
     --label 标签              使用 <标签> 替代文件名和时间戳（可以重复）  
  
 -t, --expand-tabs             将输出中的制表符展开为空格  
 -T, --initial-tab             在每行前面加上一个制表符，以使制表符可以对齐  
     --tabsize=数字            制表符宽度（默认为 8）  
     --suppress-blank-empty    去除将要输出的空行之前的空格或制表符  
 -l, --paginate                将输出发送给 "pr" 命令进行分页  
  
 -r, --recursive                 递归比较所有子目录  
     --no-dereference            不要跟随符号链接  
 -N, --new-file                  将不存在的文件视为空文件  
     --unidirectional-new-file   若第一个文件不存在，则视为空文件  
     --ignore-file-name-case     比较文件名时忽略大小写  
     --no-ignore-file-name-case  比较文件名时不忽略大小写  
 -x, --exclude=模式              排除与 <模式> 匹配的文件  
 -X, --exclude-from=文件         排除与 <文件> 中列出的任意模式匹配的文件  
 -S, --starting-file=文件        比较目录时，从 <文件> 开始比较  
     --from-file=文件1           将 <文件1> 和所有操作对象进行比较；  
                                   <文件1> 可以是目录  
     --to-file=文件2             将所有操作对象和 <文件2> 进行比较；  
                                   <文件2> 可以是目录  
  
 -i, --ignore-case               比较文件内容时忽略大小写  
 -E, --ignore-tab-expansion      忽略制表符展开造成的变更  
 -Z, --ignore-trailing-space     忽略行末的空白字符  
 -b, --ignore-space-change       忽略空白字符数不同造成的变更  
 -w, --ignore-all-space          忽略所有空白字符  
 -B, --ignore-blank-lines        忽略所有行均为空行的变更  
 -I, --ignore-matching-lines=正则  忽略所有行均与 <正则> 表达式匹配的变更  
  
 -a, --text                      将所有文件视为文本文件  
     --strip-trailing-cr         去除输入内容行末的回车 (CR) 字符  
  
 -D, --ifdef=名称                输出含 "#ifdef <名称>" 格式 diff 的合并后的文件  
     --组类型-group-format=组格式  使用 <组格式> 对 <组类型> 的输入行组进行格式化  
     --line-format=行格式        使用 <行格式> 对所有输入行进行格式化  
     --行类型-line-format=行格式  使用 <行格式> 对 <行类型> 的输入行进行格式化  
   这些格式化选项提供对 diff 输出的精细控制，是一般化的 -D/--ifdef 选项。  
   <行类型> 可以是 "old"、"new" 或 "unchanged"。<组类型> 可以是 <行类型>  
   的所有选项，或者 "changed"。  
   （仅有）<组格式> 可以包含：  
     %<  来自 <文件1> 的行  
     %>  来自 <文件2> 的行  
     %=  <文件1> 和 <文件2> 共有的行  
     %[-][宽度][.[精度]]{doxX}字符  以 printf 风格的说明符打印 <字符> 对应的值  
       <字符> 对应的值如下（大写表示新文件的行组，小写表示旧文件的行组）：  
         F  行组中第一行的行号  
         L  行组中最后一行的行号  
         N  行数，等于 L-F+1  
         E  F-1  
         M  L+1  
     %(A=B?T:E)  如果 A 等于 B，则为 T，否则为 E  
   （仅有）<行格式> 可以包含：  
     %L  该行的内容  
     %l  该行的内容，但不包括末尾的换行符  
     %[-][宽度][.[精度]]{doxX}n  以 printf 风格的说明符打印输入行的行号  
   <组格式> 和 <行格式> 均可以包含：  
     %%        %  
     %c'C'     单个字符 C  
     %c'\OOO'  八进制码 OOO 所代表的字符  
     C         字符 C（除上述转义外的其他字符代表它们自身）  
  
 -d, --minimal            尽可能找出最小的差异集  
     --horizon-lines=数字  保留 <数字> 行共有的前缀和后缀  
     --speed-large-files  假设文件很大，且含有很多零散的微小变更  
     --color[=何时]       使用彩色输出；<何时> 可以是 "never"、"always"  
                            或 "auto"；仅指定 --color 等价于 --color='auto'  
     --palette=调色板     在 --color 选项启用时使用的颜色；<调色板> 是  
                            以冒号分隔的 terminfo 能力列表  
  
     --help               显示此帮助信息并退出  
 -v, --version            显示版本信息并退出  
  
<文件列表> 可以是 "文件1 文件2"、"目录1 目录2"、"目录 文件" 或 "文件 目录"。  
如果使用了 --from-file 或 --to-file 选项，<文件列表> 的格式则不受限制。  
如果 <文件> 是 "-"，则读取标准输入的内容。  
如果输入相同，则退出状态为 0；1 表示输入不同；2 表示有错误产生。
```