FROM mysql:8.0.27

COPY ./scripts/init /usr/local/bin/docker-entrypoint.sh
COPY ./scripts/0-credentials /docker-entrypoint-initdb.d/0-credentials.sh
COPY ./scripts/1-master /docker-entrypoint-initdb.d/1-master.sh
COPY ./scripts/2-replica /docker-entrypoint-initdb.d/2-replica.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /docker-entrypoint-initdb.d/0-credentials.sh
RUN chmod +x /docker-entrypoint-initdb.d/1-master.sh
RUN chmod +x /docker-entrypoint-initdb.d/2-replica.sh

COPY ./scripts/cli /usr/local/mysql-repl
RUN mkdir -p /usr/local/mysql-repl/conf.d
RUN chown mysql:mysql -R /usr/local/mysql-repl
RUN chmod +x -R /usr/local/mysql-repl

RUN ln -s /usr/local/mysql-repl/main /usr/local/bin/mysql-repl
