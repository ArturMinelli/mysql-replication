#!/bin/bash

echo $MYSQL_ROLE

if [ "$MYSQL_ROLE" != "master" ]; then 
  exit
fi

echo "Scheduling mysql replication commands..."

(

    sleep 20

    echo "Creating replication user..."

    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "
        CREATE USER '$MYSQL_REPLICATION_USER'@'%' IDENTIFIED WITH mysql_native_password BY '$MYSQL_REPLICATION_PASSWORD';

        GRANT REPLICATION SLAVE ON *.* TO '$MYSQL_REPLICATION_USER'@'%';

        FLUSH PRIVILEGES;
    "

) &

echo "Done"
