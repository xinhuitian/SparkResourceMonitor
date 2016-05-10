monitor_home=`pwd`
for slave in `cat slaves`
do
	slave_hostname=`ssh $slave "hostname"`
	echo $slave_hostname
	scp $slave:$monitor_home/*$slave_hostname.log ./logs/
done
