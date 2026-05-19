gpasswd：管理 /etc/group 和 /etc/gshadow
```bash
用法：gpasswd [选项] 组，  
  
选项：  
 -a, --add USER                ⚠️向组 GROUP 中添加用户 USER  
 -d, --delete USER             ⚠️从组 GROUP 中添加或删除用户    
 -h, --help                    显示此帮助信息并退出删  
 -Q, --root CHROOT_DIR         要 chroot 进的目录  
 -r, --remove-password         移除组 GROUP 的密码    
 -R, --restrict                向其成员限制访问组 GROUP  
 -M, --members USER,...        设置组 GROUP 的成员列表U  
 -A, --administrators ADMIN,...设置组的管理员列表员  

除非使用 -A 或 -M 选项，不能结合使用这些选项。
```
