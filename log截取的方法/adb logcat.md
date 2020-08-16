# abd logcat
前提：adb 已打开，通过公对公转接线连接PC与设备
cmd输入命令行：
'''
adb devices #确认设备的地址
abd logcat -G 265M #设置log文件大小
adb logcat > 目标文件.txt   or  adb logcat -v time> 目标文件.txt
'''
复现问题
截取充足log信息后，Ctr+C结束
分享txt文档，notpad查看log信息


# adb logcat -b all截取
'''
adb shell setprop.logd.size 25M
adb logcat -b all > 目标文件.txt
'''

# DMesg （kernel log） 截取
'''
adb root
adb remount
adb shell dmesg -c   这一步不需要
adb shell dmesg -w > 目标文件.txt 
'''
