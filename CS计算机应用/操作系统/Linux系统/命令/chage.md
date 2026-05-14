### chage

chage：修改帐号和密码的有效期限

```bash
chage [选项] 登录名  
  
选项：  
 -d, --lastday 最近日期        将最近一次密码设置时间设为“最近日期”  
 -E, --expiredate 过期日期     将帐户过期时间设为“过期日期”  
 -h, --help                   显示此帮助信息并退出过  
 -i, --iso8601                打印日期时使用YYYY-MM-DD  
 -I, --inactive INACITVE      过期 INACTIVE 天数后，设定密码为失效状态
 -l, --list                   显示帐户年龄信息  
 -m, --mindays 最小天数        将两次改变密码之间相距的最小天数设为“最小天数”
 -M, --maxdays 最大天数        将两次改变密码之间相距的最大天数设为“最大天数”
 -R, --root CHROOT_DIR        chroot 到的目录
 -P, --prefix PREFIX_DIR      路径前缀
 -W, --warndays 警告天数       将过期警告天数设为“警告天数”
```