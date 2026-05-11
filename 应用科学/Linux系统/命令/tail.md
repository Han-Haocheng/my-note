# tail
```bash
用法：tail [选项]... [文件]...  
将每个 <文件> 的最后 10 行输出到标准输出。  
如果指定了多个 <文件>，程序会在每个文件的开头添加文件名作为头部。  
  
如果没有指定 <文件>，或者 <文件> 为 "-"，则从标准输入读取。  
  
长选项的必选参数对于短选项也是必选的。  
 -c, --bytes=[+]NUM  
        output the last NUM bytes;  
        or use -c +NUM to output starting with byte NUM of each file  
     --debug  
        indicate which --follow implementation is used  
 -f, --follow[={name|descriptor}]  
        output appended data as the file grows;  
        an absent option argument means 'descriptor'  
 -F  
        同 --follow=name --retry  
 -n, --lines=[+]NUM  
        output the last NUM lines, instead of the last 10;  
        or use -n +NUM to skip NUM-1 lines at the start  
     --max-unchanged-stats=N  
        with --follow=name, reopen a FILE which has not  
        changed size after N (default 5) iterations  
        to see if it has been unlinked or renamed  
        (this is the usual case of rotated log files);  
        with inotify, this option is rarely useful  
     --pid=PID  
        with -f, exit after PID no longer exists;  
        can be repeated to watch multiple processes  
 -q, --quiet, --silent  
        never output headers giving file names  
     --retry  
        即使目标文件无法访问，仍然不断尝试打开  
 -s, --sleep-interval=N  
        with -f, sleep for approximately N seconds  
        (default 1.0) between iterations;  
        with inotify and --pid=P,  
        check process P at least once every N seconds  
 -v, --verbose  
        总是输出含有文件名的头  
 -z, --zero-terminated  
        以 NUL 空字符而非换行符作为行分隔符  
     --help  
        display this help and exit  
     --version  
        output version information and exit  
  
<数字> 后面可以加上乘数后缀：  
b 512、kB 1000、K 1024、MB 1000*1000、M 1024*1024、  
GB 1000*1000*1000、G 1024*1024*1024，T、P、E、Z、Y、R、Q 以此类推。  
也可以使用二进制前缀：KiB=K、MiB=M，以此类推。  
  
使用 --follow (-f) 时，tail 默认跟踪文件描述符，这意味着即使 tail 跟踪的  
文件被重命名，tail 仍会继续跟踪文件的尾部。如果您希望跟踪一个文件的实际名称  
而非文件描述符（例如跟踪轮转日志时），这种默认行为可能不是您想要的。在这种  
情况下，请使用 --follow=name 选项。这会使 tail 一直跟踪指定名称的文件，并且  
不受文件重命名、删除和创建操作的影响。
```