#!/bin/bash
exit_code=0
exit_code="$(mysql --password="${MYSQL_ROOT_PASSWORD}" --execute="show databases;" 2>&1 >/dev/null | echo ${?})"
if [ "${exit_code}" != 0 ]; then
   echo "MariaDB server not accessible"
   exit 1
fi
echo "MariaDB server accessible"
exit 0