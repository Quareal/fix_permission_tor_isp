#! /bin/bash
RD=`tput setaf 1`
GR=`tput setaf 2`
RS=`tput sgr0`

IfRun(){
	PID=`cat /var/run/tor/tor.pid`
	RUNNING=`ps -ef | grep -v grep | grep $PID | wc -l`
	echo "$RUNNING"
}


Running(){
	echo "${GR}# Tor: running #${RS}"
	chmod 0700 /var/www/hidden_service/data/www/* &
	wait $!
	chmod 0700 /var/www/hidden_service/data/www/hostorx7oztvxnuz.onion/seodomains/* &
	wait $!
	chown debian-tor:hidden_service /var/www/hidden_service/data/www/ &
	wait $!
	chown debian-tor:hidden_service /var/www/hidden_service/data/www/hostorx7oztvxnuz.onion/seodomains/ &
	wait $!
	/etc/init.d/tor force-reload &
	wait $!
	if [ $( IfRun ) == "1" ]; then
		chmod 0755 /var/www/hidden_service/data/www/* &
		wait $!
		chmod 0755 /var/www/hidden_service/data/www/hostorx7oztvxnuz.onion/seodomains/* &
		wait $!
		echo "${GR}force-reload complite${RS}"
	else
		echo "${RD}error: force-reload${RS}"
	fi
}

NotRunning(){
	echo "${RD}# Tor: not running #${RS}"
	chmod 0700 /var/www/hidden_service/data/www/* &
	wait $!
	chmod 0700 /var/www/hidden_service/data/www/hostorx7oztvxnuz.onion/seodomains/* &
	wait $!
	chown debian-tor:hidden_service /var/www/hidden_service/data/www/ &
	wait $!
	chown debian-tor:hidden_service /var/www/hidden_service/data/www/hostorx7oztvxnuz.onion/seodomains/ &
	wait $!
	/etc/init.d/tor start &
	wait $!
	if [ $( IfRun ) == "1" ]; then
		chmod 0755 /var/www/hidden_service/data/www/* &
		wait $!
		chmod 0755 /var/www/hidden_service/data/www/hostorx7oztvxnuz.onion/seodomains/* &
		wait $!
		echo "${GR}start complite${RS}"
	else
		echo "${RD}error: start${RS}"
	fi
}


if [ $( IfRun ) == "1" ]; then
	Running
else
	NotRunning
fi
