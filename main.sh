#!/bin/bash
# Restarts wifi if needed

# func progress_bar:
	# VAR $1 -> total max wait time in sec
	# VAR $2 -> 1 if there is a test to run, else 0
progress_bar () {
	local _time=$1
	local _progress="#"
	local _success=0
	for i in {0..9}
	do	
		for j in {0..9}
		do
			printf "\r[%-11s] %d%d%%" ${_progress} $i $j
			sleep $(bc <<< "scale=3; ${_time}/100")
		done
		_progress+="#"
		
		
		if [ $2 == 1 ]; then
			# test to run
			if [ $_success == 0 ]; then
				wget -q --spider -T 1 http://google.com
				if [ $? == 0 ]; then
					_success=1
				fi
			fi
			
			if [ $_success == 1 ]; then
				_time=$(($_time/2))
			fi
		fi
	done
	printf "\r[%-11s] 100%%" ${_progress}
} 


wget -q --spider -T 1 http://google.com

if [ $? == 0 ]; then
	echo Wifi connection is already working!
else

	nmcli radio wifi off
	echo Wifi off
	sleep .5
	echo Restarting...
	sleep .5

	progress_bar 2 0

	nmcli radio wifi on
	printf "\rWifi turned on, testing connection...\n"
	
	progress_bar 10 1
	
	wget -q --spider -T 1 http://google.com

	if [ $? == 0 ]; then
		printf "\rWifi connection is working!\n"
	else
		printf "\rWifi doesn't seams to work, wait or try again!\n"
	fi
fi

