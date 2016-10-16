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
		echo `date +"%h %d %T.000"` "[notice] ${GR}# Tor: running #${RS}"
		echo `date +"%h %d %T.000"` "[notice] ${GR}# Tor: running #${RS} @ Quareal/fix_permission_tor_isp" >> /var/log/tor/log
		chmod 0700 /var/www/{ISP_USER}/data/www/*
		chown debian-tor:{ISP_USER} /var/www/{ISP_USER}/data/www/*
		/etc/init.d/tor force-reload &
			sleep 1
		if [ $( IfRun ) == "1" ]; then
			chown {ISP_USER}:debian-tor /var/www/{ISP_USER}/data/www/*
			echo `date +"%h %d %T.000"` "[notice] ${GR}force-reload completed${RS}"
			echo `date +"%h %d %T.000"` "[notice] ${GR}force-reload completed${RS} @ Quareal/fix_permission_tor_isp" >> /var/log/tor/log
		else
			echo `date +"%h %d %T.000"` "[warn] ${RD}error: force-reload${RS}"
			echo `date +"%h %d %T.000"` "[warn] ${RD}error: force-reload${RS} @ Quareal/fix_permission_tor_isp" >> /var/log/tor/log
		fi
}

NotRunning(){
		echo `date +"%h %d %T.000"` "[warn] ${RD}# Tor: not running #${RS}"
		echo `date +"%h %d %T.000"` "[warn] ${RD}# Tor: not running #${RS} @ Quareal/fix_permission_tor_isp" >> /var/log/tor/log
		chmod 0700 /var/www/{ISP_USER}/data/www/*
		chown debian-tor:{ISP_USER} /var/www/{ISP_USER}/data/www/*
		    sleep 15
		/etc/init.d/tor start &
			sleep 1
		if [ $( IfRun ) == "1" ]; then
			chown {ISP_USER}:debian-tor /var/www/{ISP_USER}/data/www/*
			echo `date +"%h %d %T.000"` "[notice] ${GR}start completed${RS}"
			echo `date +"%h %d %T.000"` "[notice] ${GR}start completed${RS} @ Quareal/fix_permission_tor_isp" >> /var/log/tor/log
		else
			echo `date +"%h %d %T.000"` "[warn] ${RD}error: start${RS}"
			echo `date +"%h %d %T.000"` "[warn] ${RD}error: start${RS} @ Quareal/fix_permission_tor_isp" >> /var/log/tor/log
		fi
}

if [ $( IfRun ) == "1" ]; then
		Running
else
		NotRunning
fi
