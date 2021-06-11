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
   if [ "$(mysqlshow --user=root --password="${MYSQL_ROOT_PASSWORD}" | grep -c "${nextcloud_db}")" -ne 0 ]; then
      echo "$(date '+%c') INFO   : Creating database ${nextcloud_db}"
      mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="CREATE DATABASE ${nextcloud_db};"
   else
      echo "$(date '+%c') INFO   : Database ${nextcloud_db} already exists"
   fi
   if [ "$(mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="SELECT User FROM mysql.user;" | grep -c "${MYSQL_USER}")" = 0 ]; then
      echo "$(date '+%c') INFO   : Creating user ${MYSQL_USER} with password: ${MYSQL_PASSWORD}"
      mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="CREATE USER '${MYSQL_USER}' IDENTIFIED BY '${MYSQL_PASSWORD}'; GRANT ALL PRIVILEGES ON ${nextcloud_db}.* TO ${MYSQL_USER}; FLUSH PRIVILEGES;"
   else
      echo "$(date '+%c') INFO   : Database ${MYSQL_USER} already exists"
   fi
}

if getent hosts kodi >/dev/null 2>&1; then
   if [ "${kodi_password}" = "kodi" ]; then
      echo "$(date '+%c') ERROR:   Will not create kodi user with default Kodi password. This is a security risk as it needs root priviliges during installation/upgrade"
      sleep 60
      exit 1
   fi
   InitialiseKodi
fi
if getent hosts nextcloud >/dev/null 2>&1; then InitialiseNextcloud; fi
