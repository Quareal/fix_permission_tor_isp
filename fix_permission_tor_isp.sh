#!/bin/sh
RESULT=`pgrep tor`

if [ "${RESULT:-null}" = null ]; then
	echo "not running"
	chmod 0700 /var/www/{ISP_USER}/data/www/*
	chown debian-tor:{ISP_USER} /var/www/hidden_service/data/www/
	service tor start
	chmod 0755 /var/www/{ISP_USER}/data/www/*
else
	echo "running"
fi
