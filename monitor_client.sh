function NETSTAT() {
	net=eth0
	hostname=`hostname`
	`cat $hostname > NET_$hostname.log`
	while true
	do
		`cat /proc/net/dev | grep $net >> NET_$hostname.log`
		sleep 2
	done
}

function JVMSTAT() {
        disk=sda
	while true
	do
		process=`jps | grep CoarseGrainedExecutorBackend`;
	
		if [ "$process" == "" ]; then
			sleep 1;
#			echo "no process";
		else
			echo "process exists, id is ${process% *}";
			vmid=${process% *}
			hostname=`hostname`
			`vmstat 2 > VM_$hostname.log &`
			`free -m -s 2 | grep Mem: > MEM_$hostname.log &`
			`jstat -gc $vmid 2000 > JStat_$hostname.log &`	
			`iostat -k -d 2 -x | grep $disk > DISK_$hostname.log &`
			NETSTAT &
			#`jstat -gc $vmid 2000`
			break;
		fi
	done
}

# the master node
host=hw005
echo "Starting Client on `hostname`"
JVMSTAT
flag=0
while true
do
	ps -ef | grep -i jstat | grep -v grep
	if [ $? -ne 0 ]
	then
		vmproc=`ps -ef | grep vmstat | grep -v grep | tr " " "\n"`
		memproc=`ps -ef | grep free | grep -v grep | tr " " "\n"`
		#arr1=$(vmproc | tr " " "\n")
		#arr2=$(memproc | tr " " "\n")
		echo ${vmproc[5]} ${vmproc[6]} ${vmproc[7]}
		`killall vmstat`;`killall free`;`killall iostat`
		break
	else
#		echo "not dead"
		sleep 2
	fi
done
#hostname=`hostname`
#scp VM_$hostname.log MEM_$hostname.log JStat_$hostname.log $host:`pwd`/
