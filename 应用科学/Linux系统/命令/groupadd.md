groupadd：创建一个新组

```bash
groupadd [选项] 组    
  
选项:  
 -f, --force                   如果组已经存在则成功退出
                               并且如果 GID 已被使用则取消 -g  
 -g, --gid GID                 为新组使用 GID  
 -h, --help                    显示此帮助信息并退出用  
 -K, --key KEY=VALUE           不使用 /etc/login.defs 中的默认值e  
 -o, --non-unique              允许创建有重复 GID 的组    
 -p, --password PASSWORD       为新组使用此加密过的密码    
 -r, --system                  创建一个系统账户  
 -R, --root CHROOT_DIR         chroot 到的目录户  
 -P, --prefix PREFIX_DIR       directory prefix  
 -l, --list                    该组的用户成员列表
```