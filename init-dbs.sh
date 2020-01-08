#!/bin/bash

InitialiseKodi(){
   if [ "$(mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="SELECT User FROM mysql.user;" | grep -c kodi)" = 0 ]; then
      echo "$(date '+%c') INFO   : Creating user kodi with password: ${KODIPASSWORD:=Skibidibbydibyodadubdub}"
      mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="CREATE USER 'kodi' IDENTIFIED BY '${KODIPASSWORD}'; GRANT ALL PRIVILEGES ON *.* TO 'kodi'; FLUSH PRIVILEGES;"
   else
      echo "$(date '+%c') INFO   : User kodi already exists"
   fi
}

InitialiseNextcloud(){
   if [ "$(mysqlshow --user=root --password="${MYSQL_ROOT_PASSWORD}" | grep -c "${NEXTCLOUD_DB}")" = 0 ]; then
      echo "$(date '+%c') INFO   : Creating database ${NEXTCLOUD_DB}"
      mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="CREATE DATABASE ${NEXTCLOUD_DB};"
   else
      echo "$(date '+%c') INFO   : Database ${NEXTCLOUD_DB} already exists"
   fi
   if [ "$(mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="SELECT User FROM mysql.user;" | grep -c "${NEXTCLOUD_DB_USER}")" = 0 ]; then
      echo "$(date '+%c') INFO   : Creating user ${NEXTCLOUD_DB_USER} with password: ${NEXTCLOUD_DB_PASSWORD}"
      mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --execute="CREATE USER '${NEXTCLOUD_DB_USER}' IDENTIFIED BY '${NEXTCLOUD_DB_PASSWORD}'; GRANT ALL PRIVILEGES ON ${NEXTCLOUD_DB}.* TO ${NEXTCLOUD_DB_USER}; FLUSH PRIVILEGES;"
   else
      echo "$(date '+%c') INFO   : Database ${NEXTCLOUD_DB_USER} already exists"
   fi
}

if [ ! -z "${KODIENABLED}" ] && [ "${KODIENABLED}" = "True" ]; then
   if [ "${KODIPASSWORD}" = "kodi" ]; then
      echo "$(date '+%c') ERROR:   Will not create kodi user with default Kodi password. This is a security risk as it needs root priviliges during installation/upgrade"
      sleep 60
      exit 1
   fi
   InitialiseKodi
fi
if [ ! -z "${NEXTCLOUDENABLED}" ] && [ "${NEXTCLOUDENABLED}" = "True" ]; then InitialiseNextcloud; fi
