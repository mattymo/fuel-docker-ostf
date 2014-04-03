#!/bin/bash

#Set up OSTF DB
#Deprecated - now all in puppet
##Run this image with --link $nailgundb:db
#venv='/opt/fuel_plugins/ostf'
#host='0.0.0.0'
#port='8777'
#log_file='/var/log/ostf.log'
#dbuser='ostf'
#dbpass='ostf'
#dbname='ostf'
#dbhost="${DB_PORT_5432_TCP_ADDR}"
#dbport='5432'
#dbengine='postgresql+psycopg2'
#
##$venv/bin/ostf-server --host=${host} --port=${port} --log_file=${logfile} \
##--dbpath "${dbengine}://${dbuser}:${dbpass}@${dbhost}:${dbport}/${dbname}" \
##--after-initialization-environment-hook
#
puppet apply -v /root/site.pp
/usr/bin/supervisord -n
