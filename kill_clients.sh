for slave in `cat slaves`
do
	ssh $slave "killall sh monitor_client.sh"
done
