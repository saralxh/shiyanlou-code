# 有线adb

Xshell连接后，输入： 
vmf_sender -g 248 -e 1 -l 5 -f 0000000000 -c 1 & (enable car play  disable adb)

重启设备

adb devices 返回车机地址，证明已打开有线adb，可通过线连接。

# 无线adb

Xshell输入
vmf_sender -g 248 -e 1 -l 5 -f 0000000001 -c 1 & (disable car play  enable adb)

重启设备

车机和电脑连接同一热点，adb connect IP地址，adb connected，adb devices无返回。

