#!/bin/sh

t=800
#Format Day_Month_year-Hour_Month_Seconds
x=`date "+%d_%m_%y-%H_%M_%S"`

while : 
do 
	x=`date "+%d_%H_%M_%S"`
	echo "Slogs Time (30 min)- $x"
        showmem > "$x".showmem
	sleep 1
	slog2info > "$x".slogs
	sleep $t
done


