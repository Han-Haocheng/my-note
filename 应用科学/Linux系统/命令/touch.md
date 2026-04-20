### touch
touch：将每个 <文件> 的访问时间和修改时间更改为当前时间。  除非提供了 -c 或 -h 选项，否则不存在的 <文件> 将会被创建，内容为空。如果 <文件> 为 - 则特殊处理，程序将更改与标准输出相关联的文件的时间。长选项的必选参数对于短选项也是必选的。  


```bash
touch [选项]... 文件...  
```

选项

| 缩写                         | 选项                     | 含义                                                                                                                          |
| -------------------------- | ---------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `-a`                       |                        | 只更改访问时间                                                                                                                     |
| `-c`                       | `--no-create`          | 不创建任何文件                                                                                                                     |
| `-d`                       | `--date=字符串`           | 使用 <字符串> 表示的时间，而非当前时间                                                                                                       |
| `-f`                       | <br>                   | （被忽略）                                                                                                                       |
| `-h`                       | `--no-dereference`<br> | affect each symbolic link instead of any referenced file;useful only on systems that can change the timestamps of a symlink |
| `-m`                       |                        | 只更改修改时间                                                                                                                     |
| `-r`                       | `--reference=文件`<br>   | 使用此文件的时间戳，而非当前时间                                                                                                            |
| `-t [[CC]YY]MMDDhhmm[.ss]` | <br>                   | use specified time instead of current time,  with a date-time format that differs from -d's  '                              |
|                            | `--time=WORD`<br>      | specify which time to change:access time (-a): 'access', 'atime', 'use';modification time (-m): 'modify', 'mtime'           |
