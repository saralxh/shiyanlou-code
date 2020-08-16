# abd logcat
前提：adb 已打开，通过公对公转接线连接PC与设备

cmd输入命令行：

adb devices #确认设备的地址

abd logcat -G 265M #设置log文件大小

adb logcat > 目标文件.txt  //这个命令会输出Log的格式为日志时间，进程号，线程号，Log级别，TAG,后面跟的是Log内容。

例如：04-27 21:55:45.502  1315  1341 D PowerManagerService: updateWakeLockSummaryLocked: mWakefulness=

adb logcat -v time> 目标文件.txt //输出的日志没有线程号。设置日志输入格式，默认的是brief 格 式

例如：04-27 22:03:14.560 D/WifiStateMachine( 1315):  isHighRSSI 

复现问题 

截取充足log信息后，Ctr+C结束

分享txt文档，notpad查看log信息

# adb logcat -b all截取
adb shell setprop.logd.size 25M

adb logcat -b all > 目标文件.txt //查看所有日志缓冲区

adb logcat -b main //查看主要的日志缓冲区；main缓冲区 - 默认的缓冲区 adb logcat -b system缓冲区 - 与系统相关的日志信息 -b radio   // 打印缓冲区内的radio 日志（电话相关的日志信息），是时时更新的，只要串口没断

adb logcat -v time -d radio  // 打印从开机到此时的缓冲区内的radio 日志(电话相关的日志信息)

# DMesg （kernel log） 截取
adb root

adb remount

adb shell dmesg -c   清除旧的

adb shell dmesg -w > 目标文件.txt //查看warning级别的log

#怎样抓取完整的开机过程dmesg log

注意，必须确保抓dmesg log的命令在设备重启完毕前输入。也可以两个命令在notepad++等文本编辑工具中写好了，一起复制到cmd窗口中

adb reboot //重启设备

adb wait-for-usb-device shell dmesg >dmesg.txt  //旧的adb版本用的是adb wait-for-device命令，新的adb 版本用的是adb wait-for-usb-device命令


