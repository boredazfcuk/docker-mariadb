#!/bin/bash
exit_code=0
exit_code="$(mysql --password="${MYSQL_ROOT_PASSWORD}" --execute="show databases;" 2>&1 >/dev/null | echo ${?})"
if [ "${exit_code}" -ne 0 ]; then
   echo "MariaDB server not responding on port 3306"
   exit 1
fi
echo "MariaDB server accessible"
exit 0