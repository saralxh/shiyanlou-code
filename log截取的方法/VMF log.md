# 电脑和设备通过特定网线连接，VMF log截取方法(音声问题要求截取的场合比较多）

1.网络和共享中心更改设置TCP/IPV4

2.禁用无线网络

3.有线adb的情况下 :

'''adb devices

adb root

adb shell

echo 1 > /proc/sys/net/ipv4/ip_forward

运行enable_qnx_bat.bat 文档

4.无线adb的情况下：

adb connect IP地址 然后同有线adb操作

5.确认网络是否连接，未连接 重启设备试试，VMF Analyzer界面显示绿色图标 则表明已连接VMF

# 开启设备热点，电脑连接设备热点 截取VMF log的方法：
