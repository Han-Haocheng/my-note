passwd：更改用户密码
```bash
passwd [选项] [登录名]  
  
选项：d  
 -a, --all                     报告所有帐户的密码状态  
 -d, --delete                  删除指定帐户的密码  
 -e, --expire                  强制使指定帐户的密码过期i  
 -h, --help                    显示此帮助信息并退出  
 -k, --keep-tokens             仅在过期后修改密码  
 -i, --inactive INACTIVE       密码过期后设置密码不活动为 INACTIVE  
 -l, --lock                    锁定指定的帐户  
 -n, --mindays MIN_DAYS        设置到下次修改密码所须等待的最短天数    
                               为 MIN_DAYS  
 -q, --quiet                   安静模式D  
 -r, --repository REPOSITORY   在 REPOSITORY 库中改变密码  
 -R, --root CHROOT_DIR         chroot 到的目录库  
 -P, --prefix PREFIX_DIR       directory prefix  
 -S, --status                  报告指定帐户密码的状态  
 -u, --unlock                  解锁被指定帐户  
 -w, --warndays WARN_DAYS      设置过期警告天数为 WARN_DAYS  
 -x, --maxdays MAX_DAYS        设置到下次修改密码所须等待的最多天数    
                               为 MAX_DAYS  
 -s, --stdin                   read new token from stdin
```