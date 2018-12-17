#!/bin/bash

pids=$(pgrep "bash")
acti=$(tty | cut -d'/' -f3,4)

echo "Currently open bash sessions:"
for pid in $pids
do
	if [ "$pid" != "$$" ]
	then 
		shell=$(ps -e | grep $pid | tr -s ' ' | sed -e 's/^[[:space:]]*//' | cut -d' ' -f2)
		
		if [ "$acti" != "$shell" ]
		then
			user=$(ps -u -p $pid | grep $pid | tr -s ' ' | sed -e 's/^[[:space:]]*//' | cut -d' ' -f1)
			procs=$(ps -e | grep "$shell" | tr -s ' ' | sed -e 's/^[[:space:]]*//' | cut -d' ' -f4 | grep -v bash | tr '\n' ' ')

			echo -e "pid: $pid \tshell:$shell \tuser:$user \tprocs:$procs\n"
		fi
	fi
done
