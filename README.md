# Mysql Replication

Easly setup mysql replication.

# Master Environment Variables

- MYSQL_SERVER_ID: The server ID of the master.
- MYSQL_DATABASE: The database to replicate.
- MYSQL_ROLE: The role of the server, must be `master`.
- MYSQL_USER: The user to connect to the database.
- MYSQL_PASSWORD: The password of the user.
- MYSQL_ROOT_PASSWORD: The root password of the database.
- MYSQL_REPLICATION_USER: The user to use for replication.
- MYSQL_REPLICATION_PASSWORD: The password of the replication user.

# Replica Environment Variables

- MYSQL_SERVER_ID: The server ID of the replica.
- MYSQL_DATABASE: The database to replicate.
- MYSQL_ROLE: The role of the server, must be `replica`.
- MYSQL_USER: The user to connect to the database.
- MYSQL_PASSWORD: The password of the user.
- MYSQL_ROOT_PASSWORD: The root password of the database.
- MYSQL_REPLICATION_HOST: The host of the master.
- MYSQL_REPLICATION_PORT: The port of the master.
- MYSQL_REPLICATION_USER: The user to use for replication.
- MYSQL_REPLICATION_PASSWORD: The password of the replication user.

## Important

- The server id must be unique for each server.
- The replication user credentials must be the same for both master and replica.

## Example

```yaml
services:
  mysql-master:
    image: arturminelli/mysql-replication
    container_name: mysql-master
    environment:
      MYSQL_SERVER_ID: 1
      MYSQL_DATABASE: mydb
      MYSQL_ROLE: master
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      MYSQL_ROOT_PASSWORD: root
      MYSQL_REPLICATION_USER: repl
      MYSQL_REPLICATION_PASSWORD: repl
    ports:
      - "3306:3306"
    volumes:
      - master-data:/var/lib/mysql
    networks:
      - mysql-network
    restart: always

  mysql-replica:
    image: arturminelli/mysql-replication
    container_name: mysql-replica
    environment:
      MYSQL_SERVER_ID: 2
      MYSQL_DATABASE: mydb
      MYSQL_ROLE: replica
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      MYSQL_ROOT_PASSWORD: root
      MYSQL_REPLICATION_HOST: mysql-master
      MYSQL_REPLICATION_PORT: 3306
      MYSQL_REPLICATION_USER: repl
      MYSQL_REPLICATION_PASSWORD: repl
    ports:
      - "3307:3306"
    volumes:
      - replica-data:/var/lib/mysql
    networks:
      - mysql-network
    restart: always

volumes:
  master-data:
  replica-data:

networks:
  mysql-network:

```
