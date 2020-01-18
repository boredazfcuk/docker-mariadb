#!/bin/bash

InitialiseKodi(){
   if [ "$(mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="SELECT User FROM mysql.user;" | grep -c kodi)" = 0 ]; then
      echo "$(date '+%c') INFO   : Creating user kodi with password: ${kodi_password:=Skibidibbydibyodadubdub}"
      mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="CREATE USER 'kodi' IDENTIFIED BY '${kodi_password}'; GRANT ALL PRIVILEGES ON *.* TO 'kodi'; FLUSH PRIVILEGES;"
   else
      echo "$(date '+%c') INFO   : User kodi already exists"
   fi
}

InitialiseNextcloud(){
   if [ "$(mysqlshow --user=root --password="${MYSQL_ROOT_PASSWORD}" | grep -c "${nextcloud_db}")" = 0 ]; then
      echo "$(date '+%c') INFO   : Creating database ${nextcloud_db}"
      mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="CREATE DATABASE ${nextcloud_db};"
   else
      echo "$(date '+%c') INFO   : Database ${nextcloud_db} already exists"
   fi
   if [ "$(mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="SELECT User FROM mysql.user;" | grep -c "${nextcloud_db_user}")" = 0 ]; then
      echo "$(date '+%c') INFO   : Creating user ${nextcloud_db_user} with password: ${nextcloud_db_password}"
      mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="CREATE USER '${nextcloud_db_user}' IDENTIFIED BY '${nextcloud_db_password}'; GRANT ALL PRIVILEGES ON ${nextcloud_db}.* TO ${nextcloud_db_user}; FLUSH PRIVILEGES;"
   else
      echo "$(date '+%c') INFO   : Database ${nextcloud_db_user} already exists"
   fi
}

if [ ! -z "${kodi_enabled}" ] && [ "${kodi_enabled}" = "True" ]; then
   if [ "${kodi_password}" = "kodi" ]; then
      echo "$(date '+%c') ERROR:   Will not create kodi user with default Kodi password. This is a security risk as it needs root priviliges during installation/upgrade"
      sleep 60
      exit 1
   fi
   InitialiseKodi
fi
if [ ! -z "${nextcloud_enabled}" ] && [ "${nextcloud_enabled}" = "True" ]; then InitialiseNextcloud; fi
