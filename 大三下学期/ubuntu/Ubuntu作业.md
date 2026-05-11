# **Day one**

1. **目录导航命令cd**

用于在文件系统中切换当前工作目录。

	cd – 切换目录

基本用法：cd [目录路径]

示例：cd /home/用户名/下载 进入“下载”文件夹

	cd .. – 返回上一级目录

说明：.. 代表当前目录的父目录

示例：当前在 /home/用户名/下载，执行 cd .. 后进入 /home/用户名

	cd ~ 或 cd – 返回用户主目录

说明：~ 是当前用户主目录的快捷方式

示例：任何位置执行 cd ~ 或直接 cd 都会回到 /home/用户名

2. **列表命令ls**

用于列出目录内容，可配合不同选项显示详细信息。

	ls – 列出目录内容

基本用法：ls [选项] [目录]（不指定目录则列出当前目录）

示例：ls 显示当前目录下的文件和文件夹（不包含隐藏文件）

	ls -l – 以长格式显示

说明：显示文件权限、链接数、所有者、大小、修改时间等详细信息

示例：ls -l 输出类似 -rw-r--r-- 1 user user 1024 May 1 10:00 file.txt

	ls -a – 显示所有文件（包括隐藏文件）

说明：隐藏文件以 . 开头，如 .bashrc

示例：ls -a 会显示 .、.. 及所有隐藏文件

3. **目录操作命令 pwd**

	pwd – 显示当前工作目录的绝对路径

示例：输入 pwd 输出 /home/username/project

4. **目录操作命令 mkdir**

	mkdir – 创建新目录

基本用法：mkdir 目录名

示例：mkdir my_folder 在当前目录创建 my_folder

高级选项：mkdir -p 父目录/子目录 可一次性创建多级目录（即使父目录不存在）

5. **文件操作与编辑命令 touch**

用于创建、编辑、移动、删除和查看文件。

	touch – 创建空文件或更新文件时间戳

示例：touch newfile.txt 创建一个空文件

6. **文件操作与编辑命令 vi**

	vi – 文本编辑器

基本用法：vi 文件名 打开或创建文件

简单操作：

进入后处于命令模式，按 i 进入插入模式开始编辑

编辑完成后按 Esc 返回命令模式

输入 :wq 保存并退出；输入 :q! 不保存强制退出

7. **文件操作与编辑命令 mv**

mv – 移动文件/目录，或重命名

	移动：mv 文件 目标目录/

	重命名：mv 旧名 新名

示例：mv report.docx 文档/ 将文件移到“文档”目录；mv old.txt new.txt 重命名

8. **文件操作与编辑命令 rm**

rm – 删除文件或目录

	删除文件：rm 文件名

	删除目录：rm -r 目录名（递归删除） 或者 {rm [选项] 目录名}

⚠️ 慎用：rm -rf 目录/文件 强制递归删除，不提示，无法恢复

9. **文件操作与编辑命令 cat**

	cat – 查看小型文件内容（也可用于合并文件）

示例：cat README.md 在终端直接显示文件内容

10. **辅助命令 clear**

	clear – 清空终端屏幕

	快捷键：Ctrl + L 效果相同

示例：输入 clear 后屏幕干净如新

# **Day two**

1. **su命令**:临时改变用户身份

	(1) su [选项] [用户名]

	(2) 按exit退出

2. **more命令**:显示文件内容,逐页显示

	(1) more [选项] <文件>...

	(2) q结束

3. **less命令**：显示文件内容，逐页显示，比more功能更强

	(1) less [选项] <文件>...

	(2) q结束

4. **head命令**：显示文件开头若干行或若干节

	(1) head [选项]... [文件]...
   （2）head -5 example   前5行

5. **tail命令**：显示文件末尾若干行或若干节

	(1) tail [选项]... [文件]...

6. **od命令**：按照特殊格式查看文件内容

	(1) od [选项]... [文件]...

	(2) 默认八进制

7. **grep命令**：查找文件内容

	(1) grep [选项]... 模式 [文件名]...

	(2) -i:忽略大小写

	(3) -x:强制整行匹配

	(4) -w:强制关键字匹配

	(5) -v：排除匹配的行

8. **sort命令**：对文件排序

	(1) sort [选项]... [文件]...

	(2) sort命令，只是显示，实际没改

9. **wc命令**：统计文件的字节数、字数、行数、并输出结果。

	(1) wc [选项]... [文件名]...

	(2) 显示的具体格式：
		行数 字数 字节数 文件名
		-c字节数  -l行数  -w字数

10. **diff**:比较文件内容,列出不同

	(1) diff [选项] 文件1 文件2

# **Day** **three**

1. groups命令:打印每个 <用户名> 所在的全部组，如果没有指定 <用户名>，则打印当前进程的组

	(1) groups [用户名]...

	(2) cat /etc/group   #查看所有组

2. adduser命令:创建用户

	(1) sudo adduser [用户名]

	(2) sudo adduser [用户名] sudo  ##添加到sudo组

3. su命令：切换用户

	(1) su [用户名]

4. man命令：查看命令的一些功能

	(1) man [命令]

5. usermod命令：用户重命名

(1) sudo usermod -l [新用户名] [旧用户名]

6. passwd命令：用户配置

	(1) cat passwd      # 查看用户配置

	(2) sudo passwd [用户名]   #设置用户密码

7. history命令：显示操作历史

8. deluser命令：删除用户

	(1) sudo deluser --remove-all-files [用户名]

9. delgroup命令：删除组中的指定用户(因为删除用户时，不能删除组内的用户)

	(1) sudo delgroup [用户名]

10. pkill:结束用户进程

	(1) sudo pkill -u [用户名]

	(2) ps -aux | grep [用户名]   #查看用于进程

# **Day** **four**

1. useradd命令:创建用户(通用)

	(1) -m：同时创建主目录

	(2) -r：创建管理员

	(3) sudo useradd [选项] [用户名]

	(4) 将用户添加到组：sudo useradd [用户名] [组名]

2. userdel命令:删除用户

	(1) -r：删除更干净

	(2) sudo userdel [选项] [用户名]

3. addgroup命令：创建组(ubuntu专用)

	(1) sudo addgroup [组名]

4. gpasswd命令：把用户添加到组或移除

	(1) -a：将用户添加到组

	(2) -d：将用户移除出该组

	(3) sudo gpasswd [选项] [用户名] [组名]

5. whoami命令：显示当前操作的用户

6. top命令：动态显示系统进程状态

	(1) 实时显示CPU、内存使用情况，进程列表（按 q 退出）

	(2) 快捷键：P 按CPU排序，M 按内存排序，k 终止进程

7. free命令：查看内存使用情况

	(1) -h 以人类可读格式显示总内存、已用、空闲、缓存等

	(2) free -h

8. uname命令：查看系统内核信息

	(1) uname -a

	(2) 说明：显示操作系统名称、内核版本、主机名、架构等详细信息

9. date命令：显示时间

10. echo命令：输出文字

	(1) echo “字符串”

# Day five

1. ln命令:创建链接文件

	(1) ln -s 目标文件 链接文件(是系统中不存在的文件)
	
	(2) ln 目标文件 链接文件(是系统中不存在的文件)

2. gzip 命令：对文件进行压缩和解压缩

	(1) gzip [选项] 压缩文件名/解压缩文件名

3. unzip 命令：对WinZip格式的压缩文件解压缩

	(1) unzip [选项] 压缩文件名

4. tar 命令：对文件或目录进行压缩或解压缩

	(1) tar [选项] 文件或目录名

	(2) -c 创建、-x 解压、-t 查看

	(3) -cvf 创建 .tar 包（打包）

	(4) -czvf 创建 .tar.gz 压缩包（打包+压缩）

	(5) -xvf 解压 .tar 包

	(6) -xzvf 解压 .tar.gz 包

	(7) -tvf 查看 .tar 包内容（不解压）

	(8) -tzvf 查看 .tar.gz 包内容（不解压）

5. chown 命令：变更所有者

	(1) chown [选项]... [所有者][:[组]] 文件...

		① 如 sudo chown wang news

	(2) 也可以变更所属组：

		① chown [选项] [新所有者]: [新的所属组] 文件列表

6. chgrp 命令：变更所属组

	(1) chgrp [选项]... 所属组 文件...

	(2) sudo chgrp 新组名 文件名

7. chmod 命令：设置文件权限（读-4,写-2,执行-1）

	(1) chmod [选项]... 模式[,模式]... 文件名...

		① 如chmod 644 myfile  :所有者-6,所属组-4,其他用户权限-4

8. umask 命令：设置默认的文件的文件权限

	(1) 查看当前的umask：umask

	(2) 修改：umask XXXX

9. ps 命令：监控后台进程

10. kill 命令：结束进程

	(1) kill [-s,--信号|-p] [-a] PID

	(2) kill PID              # 正常终止

	(3) kill -9 PID          # 强制终止

	(4) kill -15 PID         # 同 kill PID

	(5) kill -2 PID          # 相当于 Ctrl+C

	(6) killall 进程名        # 杀死所有同名进程

	(7) pkill 进程名          # 按名称杀死进程

	(8) kill -l              # 列出所有信号

	(9) kill -L              # 详细列出信号


# Day six

1. stat – 查看文件的详细属性

	(1) 作用：显示文件大小、权限、访问时间、修改时间等

	(2) 用法：stat 文件名

2. tree – 以树形结构显示目录内容

	(1) 安装：sudo apt install tree

	(2) 用法：tree 或 tree 目录名

3. hostnamectl – 查看系统主机名和版本信息

	(1) 作用：显示操作系统版本、内核、主机名

4. lscpu – 查看CPU详细信息

	(1) 作用：显示CPU架构、核心数、型号、频率等

5. lsmem – 查看内存信息

	(1) 作用：显示内存大小、可用内存、内存块信息

6. logname – 显示登录用户名

	(1) 作用：显示最初登录系统的用户名（与whoami不同）

7. which – 查看命令的绝对路径

	(1) 作用：显示某个命令在文件系统中的位置

	(2) 用法：which 命令名

8. printf – 格式化输出文字

	(1) 作用：比echo更强大的输出命令

	(2) 用法：printf "格式" 内容

9. basename – 从路径中提取文件名

	(1) 作用：去掉路径中的目录部分，只保留最后的文件名

	(2) 用法：basename 路径

10. dirname – 从路径中提取目录部分

	(1) 作用：去掉路径中的文件名部分，只保留目录路径

	(2) 用法：dirname 路径


# **Day seven**

1. df – 查看磁盘使用情况

df – 显示文件系统磁盘空间使用量

常用选项：df -h 以人类可读格式（K, M, G）显示挂载点、总容量、已用、可用、使用率

2. du – 查看目录/文件大小

du – 统计目录或文件所占磁盘空间大小

常用选项：du -sh 目录名 汇总显示该目录的总大小（-s 汇总，-h 人类可读）

3. find – 查找文件

find – 在目录层级中搜索文件

基本用法：find 路径 -name "文件名"

示例：find /home -name "*.txt" 查找所有 .txt 文件

补充：-type d 查找目录，-type f 查找普通文件

4. alias – 设置命令别名

alias – 为长命令创建短别名

用法：alias 别名='原始命令'

示例：alias ll='ls -alF' 之后输入 ll 即可执行长列表

查看所有别名：直接输入 alias

5. unalias – 取消命令别名

unalias – 移除已设置的别名

用法：unalias 别名

6. wget – 网络下载工具

wget – 非交互式网络下载文件

基本用法：wget URL

补充：wget -c URL 断点续传下载

7. curl – 网络数据传输工具

curl – 利用 URL 规则传输数据，支持多种协议

基本用法：curl URL 获取网页内容

示例：curl -O URL 下载文件并以远程文件名保存

8. ssh – 远程登录

ssh – 安全 Shell 客户端，用于登录远程主机

用法：ssh 用户名@主机地址

示例：ssh user@192.168.1.100

补充：-p 指定端口，如 ssh -p 2222 user@host

9. shutdown – 关机/重启

shutdown – 安全关闭或重启系统

立即关机：sudo shutdown -h now

立即重启：sudo shutdown -r now

定时关机：sudo shutdown -h +10 （10分钟后关机）

10. reboot – 重启系统

reboot – 立即重新启动系统

用法：sudo reboot


# **Day eight**

1. cut – 文本列提取

(1) cut – 从文本行中提取指定列（字段）

(2) 基本用法：cut -d "分隔符" -f 列号 文件名

(3) 示例：cut -d ":" -f 1 /etc/passwd 提取所有用户名

(4) 补充选项：-c 按字符位置提取，如 cut -c 1-5 文件名 提取每行前5个字符

2. sed – 流编辑器

(1) sed – 对文本进行过滤和替换操作

(2) 基本替换：sed 's/旧内容/新内容/g' 文件名

(3) 示例：sed 's/foo/bar/g' file.txt 将所有foo替换为bar

(4) 补充：-i 直接修改文件，-n 静默模式配合 p 打印指定行

3. awk – 文本处理工具

(1) awk – 强大的文本分析和格式化工具

(2) 基本用法：awk '{print $1, $3}' 文件名 打印第1列和第3列

(3) 示例：awk -F: '{print $1, $7}' /etc/passwd 查看用户名及其Shell

(4) 补充：-F 指定分隔符，支持条件判断和内置变量

4. ping – 网络连通性测试

(1) ping – 向目标主机发送ICMP请求，测试网络连通性

(2) 用法：ping 主机地址或域名

(3) 示例：ping baidu.com

(4) 补充：-c 4 发送4个包后停止，-i 2 设置发送间隔为2秒

5. ss – 网络连接查看

(1) -t：仅显示 TCP

(2) -l：仅显示正在监听的端口

(3) -n：以数字形式显示端口号（不解析服务名

6. scp – 远程文件复制

(1) scp – 基于SSH在主机间安全复制文件

(2) 下载：scp 用户@远程主机:远程路径 本地路径

(3) 上传：scp 本地文件 用户@远程主机:远程路径

(4) 示例：scp file.txt user@192.168.1.10:/home/user/

(5) 补充：-r 递归复制目录，-P 端口号 指定端口

(6) 

7. rsync – 远程同步工具

(1) rsync – 高效的文件同步与传输工具（支持断点续传）

(2) 基本用法：rsync -av 源目录/ 目标目录/

(3) 示例：rsync -avz /local/dir/ user@host:/remote/dir/ 同步到远程

(4) 补充：-a 归档模式保持属性，-v 详细输出，--delete 删除目标多余文件

8. fdisk - 分区管理

(1) sudo fdisk -l 查看现有分区

9. file – 查看文件类型

(1) file – 检测并显示文件类型（文本、二进制、目录等）

(2) 用法：file 文件名

(3) 示例：file /bin/ls 输出 ELF 64-bit executable

(4) 补充：file -i 文件名 显示 MIME 类型

10. type – 查看命令类型

(1) type – 判断一个命令是内置命令、别名还是外部程序

(2) 用法：type 命令名

(3) 示例：type ls 输出 ls is aliased to...

(4) 补充：type -a 命令名 显示所有匹配位置

Day nine
1.tr – 字符替换或删除
(1)tr – 从标准输入替换或删除字符
(2)基本用法：tr '原字符' '新字符'
(3)示例：echo "hello" | tr 'a-z' 'A-Z' 输出 HELLO
(4)补充：tr -d '字符' 删除指定字符，tr -s '字符' 压缩重复字符

2.uniq – 去重
(1)uniq – 去除或统计重复行（需配合 sort 使用）
(2)基本用法：sort 文件 | uniq 去重
(3)示例：sort list.txt | uniq -c 统计每行出现次数
(4)补充：uniq -d 仅显示重复行，uniq -u 仅显示唯一行

3.paste – 合并文件列
(1)paste – 横向合并多个文件的对应行
(2)基本用法：paste 文件1 文件2
(3)示例：paste names.txt scores.txt 将两个文件并列显示
(4)补充：paste -d "分隔符" 指定分隔符

4.uptime – 查看系统运行时间
(1)uptime – 显示系统已运行时间、登录用户数、负载平均值
(2)用法：uptime
(3)示例输出：12:30:01 up 3 days, 2:15, 2 users, load average: 0.05, 0.10, 0.08

5.dmesg – 查看内核日志
(1)dmesg – 显示系统启动以来的内核环形缓冲区日志
(2)查看全部：dmesg
(3)分页查看：dmesg | less
(4)过滤错误：dmesg | grep -i error
(5)补充：dmesg -T 显示人类可读时间戳（若支持），dmesg | tail -20 查看最近日志

6.mount – 查看挂载信息
(1)mount – 显示当前已挂载的文件系统
(2)查看所有挂载：mount
(3)筛选设备：mount | grep ^/dev
(4)挂载设备：sudo mount /dev/sdb1 /mnt
(5)补充：mount -t 文件系统类型 指定类型
(6)取消挂载：sudo umount 挂载名

7.tee – 将输出同时显示在终端并写入文件
(1)基本用法：命令 | tee 文件名
(2)示例：ls -l | tee output.txt 既在屏幕看到结果，又保存到文件
(3)补充：tee -a 文件名 追加模式不覆盖

8.hostname – 显示或临时设置系统主机名
(1)查看当前主机名：hostname
(2)查看完整域名：hostname -f
(3)查看主机名对应的 IP：hostname -I
(4)临时修改（重启失效）：sudo hostname 新主机名

9.sleep – 延迟执行
(1)sleep – 暂停执行指定时长
(2)暂停秒数：sleep 3
(3)暂停分钟：sleep 1m
(4)暂停小时：sleep 2h
(5)常见用法：sleep 5 && echo "5秒后执行" 延时执行后续命令

10.cal – 显示日历
(1)cal – 显示日历
(2)当月：cal
(3)全年：cal 2025
(4)指定月：cal 5 2025 显示 2025 年 5 月