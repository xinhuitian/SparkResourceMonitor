for slave in `cat slaves`
do
#	ssh $slave "mkdir /home/L/monitor/"
	scp * $slave:/home/L/monitor/
done
