#!/bin/sh

t=800

#Format Day_Month_year-Hour_Month_Seconds
x=`date "+%d_%m_%y-%H_%M_%S"`

COUNTER=$( ls -1 | wc -l )
COUNTER=`expr $COUNTER - 1`
echo "$COUNTER"
mkdir "$COUNTER"
cd "$COUNTER"

cp /var/la_gvm.txt ./

mkdir la_gvm_dump
mkdir smmu_data
mkdir ramdumps
mkdir coredump

ksh /var/log/QNX_Slogs.sh &
ksh /var/log/Monitor.sh &
slog2info -w > tailsslog &
tail -f /var/la_gvm.txt >> la_gvmTailed &

while : 
do
	x=`date "+%d_%H_%M_%S"`
	echo "QNX Data Time (15 mins) - $x"

	pidin memory > "$x".memory 

	top -b -i 1 > "$x".top
	
	cp /var/log/ana_dumps/smmu_graphics ./smmu_data/
	cp /var/log/postmortem_smmu_graphics.txt ./smmu_data/
	cp /var/log/ana_dumps/smmu_display ./smmu_data/
	cp /var/log/display_smmu_fault_info.txt ./smmu_data/

	cp /var/log/*.core ./coredump/
 
	cat /dev/smmu/STCU/HLOS_AUDIO1 > "$x".HLOS_AUDIO1
	
	cat /dev/smmu/GPU/HLOS > "$x".HLOS
	cat /dev/smmu/GPU/GMU > "$x".GMU
	
	cat /dev/smmu/STCU/CP_B_VIDEO > "$x".CP_B_VIDEO
	cat /dev/smmu/STCU/CP_P_VIDEO > "$x".CP_P_VIDEO
	cat /dev/smmu/STCU/CP_INT_VIDEO > "$x".CP_INT_VIDEO
	cat /dev/smmu/STCU/HLOS_VIDEO > "$x".HLOS_VIDEO
	cat /dev/smmu/STCU/HLOS_CAM_IPE > "$x".HLOS_CAM_IPE
	cat /dev/smmu/STCU/HLOS_CAM_BPS > "$x".HLOS_CAM_BPS
	cat /dev/smmu/STCU/HLOS_CAM_ICPFW > "$x".HLOS_CAM_ICPFW
	cat /dev/smmu/STCU/HLOS_CAM_IFE > "$x".HLOS_CAM_IFE
	cat /dev/smmu/STCU/HLOS_MDP0 > "$x".HLOS_MDP0
	
	pidin -f aNo > "$x".unlinkedFds 
	
	pidin a > "$x".pidinA

	pidin fds > "$x".pidinfds
	pidin pmem > "$x".pidinpmem
	pidin threads > "$x".threads

	echo pmemtbl > /dev/kgsl-control
	
    	(cat /var/log/pmemtbl.txt) > "$x".pmemtbl
	
        cat /dev/thermalmgr > "$x".thermalmgr

        pidin info > "$x".pidininfo 

	cp -r /var/log/analyzer/* ./ramdumps

    	(cat /dev/pmem/screen | awk --non-decimal-data '{sum += $9} END {print sum}' |awk '{printf "%d\n",$0}') > "$x".SCREEN

    	(cat /dev/pmem/kgsl | awk --non-decimal-data '{sum += $9} END {print sum}' |awk '{printf "%d\n",$0}') > "$x".KGSL

    	(cat /dev/pmem/audio_service | awk --non-decimal-data '{sum += $9} END {print sum}' |awk '{printf "%d\n",$0}') > "$x".AUDIO_SERVICE

    	(cat /dev/pmem/videoCore | awk --non-decimal-data '{sum += $9} END {print sum}' |awk '{printf "%d\n",$0}') > "$x".VIDEOCORE

	cp /var/la_gvm.txt ./
	sync	
	echo "Sleeping" 
        sleep $t
done
