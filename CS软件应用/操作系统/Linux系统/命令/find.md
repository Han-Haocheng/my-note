### find

```bash
用法：find [-H] [-L] [-P] [-O级别] [-D 调试选项] [路径...] [表达式]  
  
默认路径为当前目录；默认表达式为 -print。  
表达式可以包含：操作符、选项、测试以及动作。  
  
操作符（优先级递减；未使用其他操作符时隐含使用 -and）：  
     ( 表达式 )   ! 表达式   -not 表达式   表达式1 -a 表达式2  
     表达式1 -and 表达式2   表达式1 -o 表达式2   表达式1 -or 表达式2  
     表达式1 , 表达式2  
  
位置选项（总是为真）：  
     -daystart -follow -nowarn -regextype -warn  
  
Normal options (always true, specified before other expressions):  
     -depth -files0-from FILE -maxdepth LEVELS -mindepth LEVELS  
     -mount -noleaf -xdev -ignore_readdir_race -noignore_readdir_race  
  
测试（N 可以是 +N 或 -N 或 N）：  
     -amin N -anewer 文件 -atime N -cmin N -cnewer 文件 -context 上下文  
     -ctime N -empty -false -fstype 类型 -gid N -group 名称 -ilname 匹配模式  
     -iname 匹配模式 -inum N -iwholename 匹配模式 -iregex 匹配模式  
     -links N -lname 匹配模式 -mmin N -mtime N -name 匹配模式 -newer 文件  
     -nouser -nogroup -path 匹配模式 -perm [-/]权限模式 -regex 匹配模式  
     -readable -writable -executable  
     -wholename 匹配模式 -size N[bcwkMG] -true -type [bcdpflsD] -uid N  
     -used N -user 名字 -xtype [bcdpfls]  
  
动作：  
     -delete -print0 -printf 格式 -fprintf 文件 格式 -print    
     -fprint0 文件 -fprint 文件 -ls -fls 文件 -prune -quit  
     -exec 命令 ; -exec 命令 {} + -ok 命令 ;  
     -execdir 命令 ; -execdir 命令 {} + -okdir 命令 ;  
  
其他常用选项：  
     --help                   显示此帮助信息并退出  
     --version                显示版本信息并退出  
  
-D 选项有效的参数为：  
exec, opt, rates, search, stat, time, tree, all, help  
使用 "-D help" 以查看选项描述，或阅读 find(1)
```
