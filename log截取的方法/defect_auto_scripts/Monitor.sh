
while :
do 
        VAR=`pidin a | grep telnet | wc -l `
        if [[ $VAR -eq  1 ]] ; then
                /usr/sbin/telnetd -debug 23 &
#               echo "Starting telnet"
        fi
done
