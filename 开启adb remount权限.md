# 开发新给的开remount权限的方法

1.Open QNX(Xshell）

2.cp /etc/linux-la.config /etc/linux-la.config-orig 

3.sed -i "s/cmdline/#xxx/g" /etc/linux-la.config

4.sed -i "s/##xxx/cmdline/g" /etc/linux-la.config

5.sync

6.重启

7.adb root

8.adb remount ---remount succeed 证明权限已开
