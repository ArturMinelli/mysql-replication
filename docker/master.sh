#!/bin/bash

function client() {
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "$1"
}

function print_step() {
    echo "[REPLICATION] [MASTER] $1"
}

if [ "$MYSQL_ROLE" != "master" ]; then 
  exit
fi

print_step "Setting up master"

(
    print_step "Waiting for mysql database to be up"

    while ! client "SELECT 1;" &> /dev/null; do
        sleep 1
    done

    print_step "Executing master commands"

    client "
        RESET MASTER;

        DROP USER IF EXISTS '$MYSQL_REPLICATION_USER'@'%';

        CREATE USER '$MYSQL_REPLICATION_USER'@'%' IDENTIFIED WITH mysql_native_password BY '$MYSQL_REPLICATION_PASSWORD';

        GRANT REPLICATION SLAVE ON *.* TO '$MYSQL_REPLICATION_USER'@'%';

        FLUSH PRIVILEGES;
    "

    print_step "Done"
) &
