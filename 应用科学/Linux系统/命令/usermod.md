usermod：
```bash
usermod [选项] 登录名
  
选项：  
 -a, --append GROUP            将用户追加至上边 -G 中提到的附加组中，  
                               并不从其它组中删除此用户  
 -q, --badname                 允许 bad name  
 -c, --comment COMMENT         GECOS 字段的新值  
 -d, --home HOME_DIR           用户的新主目录  
 -e, --expiredate EXPIRE_DATE  设定帐户过期的日期为 EXPIRE_DATE  
 -f, --inactive INACTIVE       过期 INACTIVE 天数后，设定密码为失效状态v  
 -g, --gid GROUP               强制使用 GROUP 为新主组设  
 -G, --groups GROUPS           新的附加组列表 GROUPS  
 -h, --help                    显示此帮助信息并退出P  
 -l, --login NEW_LOGIN         ⚠️新的登录名称  
 -L, --lock                    锁定用户帐号  
 -m, --move-home               将家目录内容移至新位置 (仅于 -d 一起使用)  
 -o, --non-unique              允许使用重复的(非唯一的) UID  
 -p, --password PASSWORD       将加密过的密码 (PASSWORD) 设为新密码  
 -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files  
 -r, --remove                  remove the user from only the supplemental GROUPS  
                               mentioned by the -G option without removing  
                               the user from other groups  
 -R, --root CHROOT_DIR         chroot 到的目录o  
 -s, --shell SHELL             该用户帐号的新登录 shell  
 -u, --uid UID                 用户帐号的新 UID  
 -U, --unlock                  解锁用户帐号  
 -v, --add-subuids FIRST-LAST  添加子 UID 范围I  
 -V, --del-subuids FIRST-LAST  移除子 UID 范围I  
 -w, --add-subgids FIRST-LAST  添加子 GID 范围I  
 -W, --del-subgids FIRST-LAST  移除子 GID 范围I
```