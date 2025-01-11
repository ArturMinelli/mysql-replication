FROM mysql:8.0.27

COPY ./init.sh /usr/local/bin/docker-entrypoint.sh
COPY ./master.sh /docker-entrypoint-initdb.d/master.sh
COPY ./replica.sh /docker-entrypoint-initdb.d/replica.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /docker-entrypoint-initdb.d/master.sh
RUN chmod +x /docker-entrypoint-initdb.d/replica.sh
