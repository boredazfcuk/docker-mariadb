#!/bin/bash

if [ "$(netcat -z "$(hostname -i)" 3306; echo "${?}")" -ne 0 ]; then
      echo "MariaDB server not responding on port 3306"
   exit 1
fi

echo "MariaDB server not responding on port 3306"
exit 0