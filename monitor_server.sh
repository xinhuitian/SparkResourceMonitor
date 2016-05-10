slaveConfig="./slaves"
home=`pwd`
echo "Starting Server on `hostname`"
for slave in `cat $slaveConfig`
do
	ssh $slave "cd $home/; sh monitor_client.sh" &
done

