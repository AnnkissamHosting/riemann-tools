#!/bin/sh

emails=( "eric.tao@bfortress.com" "colin.fish@bfortress.com" "billing@annkissam.com" )

for pidfile in $(find /var/www/apps/fi-billing.masscp.org/current/tmp/pids/*)
do
  if ! ps -p $(cat $pidfile) > /dev/null && [ ! -f /tmp/.resque.$(cat $pidfile)] 
  then
    right_now=$(date +%c)
		for email in ${emails[*]}
		do
      echo -e $right_now"\n""FI Billing Resque worker PID File""\n" $pidfile "\n" 'does not have a corresponding process!' | mailx -v -r "fi-billing@cpotravelproc" -s "FI Billing Production Resque worker down" $email
		done
    touch /tmp/.resque.$(cat $pidfile)
	fi
done
