userdel：删除用户账户和相关文件

```bash
userdel [选项] 登录名    
  
选项：  
 -f, --force                   强制执行一些原本会失败的操作
                               例如：删除仍然登录的用户或文件，即使这些文件不属于该用户  
 -h, --help                    显示此帮助信息并退出o  
 -r, --remove                  ⚠️删除主目录和信件池  
 -R, --root CHROOT_DIR         chroot 到的目录件  
 -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
```
