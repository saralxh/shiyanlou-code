# 清除VST log
1. Clear Log:

adb shell rm -rf /data/vstgloballogcontrol/*

2. adb shell sync

3. Reboot target

# 导出VST log

## 1.	使用adb pull 导出日志：

a)	连接adb 线

b)	adb root

c)	adb remount

d)	adb pull /data/vstgloballogcontrol “指定目录”

## 2.	使用ETM功能导出日志：

a)	将名为vstlogger_enabled的空文件拷贝到U盘根目录下

b)	Setting画面-系统设定

c)	长按“系统版本”15秒进入ETM画面

d)	点击log功能记录设定

e)	插入U盘，识别后点击Button“导出所有日志到USB”
