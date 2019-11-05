#!/bin/bash
mysql --password="$(cat /etc/mysql/conf.d/auth.conf | cut -d'=' -f 2)" --execute="show databases;" 2>&1 >/dev/null || exit 1
exit 0
