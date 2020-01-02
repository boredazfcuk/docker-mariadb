#!/bin/bash
EXITCODE=0
EXITCODE="$(mysql --password="${MYSQL_ROOT_PASSWORD}" --execute="show databases;" 2>&1 >/dev/null | echo ${?})"
if [ "${EXITCODE}" != 0 ]; then
   echo "MariaDB server not accessible"
   exit 1
fi
echo "MariaDB server accessible"
exit 0