
echo 0 > /proc/sys/kernel/kptr_restrict

COUNTER=$( ls -1 | wc -l )
COUNTER=`expr $COUNTER - 1`
echo "$COUNTER"
mkdir "$COUNTER"
cd "$COUNTER"


mkdir ANR 
mkdir Tombs

touch /data/debug.key
setprop persist.logd.size 100M

sleep 5 

dmesg -Tw > dmesgtail & 
logcat -f log.txt &
logcat -b all -f ballLog.txt &

while :
do 
	x=`date "+%d_%H_%M_%S"`
	echo "Android Slogs Time - $x"
	uptime
	
	#Checks if logcat is dead
	if [ `ps -A | grep logcat | wc -l` == 0 ]
	then 
		echo "Starting logcat again - $x"
		logcat -b all > "$x".logcatball & 		
		logcat > "$x".logcat & 
	fi
	
	#check if dmesg is dead
	if [ `ps -A | grep dmesg | wc -l` == 0 ]
        then 
		echo "Starting dmesg again - $x"
                dmesg -Tw > "$x".dmesg &
        fi

	top -b -n 1 > "$x".top &
	sleep 1
	dumpsys meminfo > "$x".dumpmem &
	sleep 1
	cp -r /data/tombstones Tombs/ 
	sleep 1 
	cp -r /data/anr ANR/
        sleep 1
	procrank > "$x".procrank &
	sleep 1 
        cp /proc/meminfo ./"$x".mem
	sleep 500
done
