#!/bin/bash

echo $MYSQL_ROLE

if [ "$MYSQL_ROLE" != "replica" ]; then
  exit
fi

echo "Scheduling mysql replication commands..."

(
    sleep 25

    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "
        STOP REPLICA;

        RESET REPLICA;

        CHANGE MASTER TO
            MASTER_HOST='$MYSQL_REPLICATION_HOST',
            MASTER_PORT=$MYSQL_REPLICATION_PORT,
            MASTER_USER='$MYSQL_REPLICATION_USER',
            MASTER_PASSWORD='$MYSQL_REPLICATION_PASSWORD';

        START REPLICA;
    "
) &

echo "Done"
