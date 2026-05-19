### sort
```
用法：sort [选项]... [文件]...  
　或：sort [选项]... --files0-from=F  
连接所有 <文件>，然后排序，并将结果写到标准输出。  
  
如果没有指定 <文件>，或者 <文件> 为 "-"，则从标准输入读取。  
  
长选项的必选参数对于短选项也是必选的。  
排序选项：  
  
 -b, --ignore-leading-blanks  
        ignore leading blanks when finding sort keys in each line  
 -d, --dictionary-order  
        只考虑空白字符、字母和数字  
 -f, --ignore-case  
        忽略大小写  
 -g, --general-numeric-sort  
        对一般化的数字进行排序  
 -i, --ignore-nonprinting  
        只考虑可打印字符  
 -M, --month-sort  
        对月份进行排序：（未知）< "1月" < ... < "12月"  
                                LC_ALL=C 时：（未知）< "JAN" < ... < "DEC"  
 -h, --human-numeric-sort  
        compare human readable numbers (e.g., 2K 1G)  
 -n, --numeric-sort  
        compare according to string numerical value;  
        see full documentation for supported strings  
 -R, --random-sort  
        shuffle, but group identical keys.  See also shuf(1)  
     --random-source=文件  
        从 <文件> 中获得随机字节  
 -r, --reverse  
        逆序输出排序结果  
     --sort=WORD  
        sort according to WORD:  
          general-numeric -g, human-numeric -h, month -M,  
          numeric -n, random -R, version -V  
 -V, --version-sort  
        natural sort of (version) numbers within text  
  
Other options:  
  
     --batch-size=NMERGE  
        merge at most NMERGE inputs at once; for more use temp files  
 -c, --check, --check=diagnose-first  
        check for sorted input; do not sort  
 -C, --check=quiet, --check=silent  
        like -c, but do not report first bad line  
     --compress-program=PROG  
        compress temporaries with PROG; decompress them with PROG -d  
     --debug  
        annotate the part of the line used to sort,  
        and warn about questionable usage to standard error  
     --files0-from=F  
        read input from the files specified by NUL-terminated names in file F;  
        If F is -, read names from standard input  
 -k, --key=键定义  
        根据某个键进行排序；<键定义> 指定键的位置及类型  
 -m, --merge  
        归并已排序的文件；不进行排序  
 -o, --output=文件  
        将结果写入到 <文件> 而非标准输出  
 -s, --stable  
        禁用最终的比较，以使排序算法成为稳定排序  
 -S, --buffer-size=大小  
        指定内存缓冲区 <大小>  
 -t, --field-separator=分隔符  
        使用 <分隔符> 而不是非空白字符到空白字符的转变  
                             作为字段分隔符  
 -T, --temporary-directory=DIR  
        use DIR for temporaries, not $TMPDIR or /tmp;  
        multiple options specify multiple directories  
     --parallel=N  
        将并发执行的排序线程数设置为 N  
 -u, --unique  
        output only the first of lines with equal keys;  
        with -c, check for strict ordering  
 -z, --zero-terminated  
        以 NUL 空字符而非换行符作为行分隔符  
     --help  
        display this help and exit  
     --version  
        output version information and exit  
  
<键定义> 是 字段[.字符][选项][,字段[.字符][选项]]，其中 <字段> 是字段编号，  
<字符> 是字段中的字符编号；两者均从 1 开始计数，且停止比较的位置默认为行末。  
如果没有指定 -t 和 -b，则字段中的字符从字段前的空格的起始位置开始计数。  
<选项> 是单字母排序选项 [bdfgiMhnRrV] 中的一个或多个，对于此键而言，  
将用 <选项> 覆盖全局排序选项。如果没有指定键，则将整个行作为键。  
可使用 --debug 诊断选取排序键时出现的错误。  
  
<大小> 后面可以加上下列乘数后缀：  
% 表示 1% 的内存大小、b 表示 1、K 表示 1024（默认）、M、G、T、P、  
E、Z、Y、R、Q 以此类推。  
  
*** 警告 ***  
环境变量里的区域设置会影响排序结果。  
如果希望按照字节的原始值进行传统的排序，请设置环境变量 LC_ALL=C。
```
