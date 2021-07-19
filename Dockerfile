FROM mariadb:10.5.11
MAINTAINER boredazfcuk
# mariadb_version not used, just increment to force a rebuild
ARG mariadb_version="10.6.0"
RUN echo "$(date '+%d/%m/%Y - %H:%M:%S') | ***** BUILD STARTED FOR MARIADB *****" && \
   apt-get update && \
   apt-get install -y tzdata netcat

COPY init-dbs.sh /docker-entrypoint-initdb.d/init-dbs.sh
COPY healthcheck.sh /usr/local/bin/healthcheck.sh

RUN echo "$(date '+%d/%m/%Y - %H:%M:%S') | Set scripts to be executable" && \
   chmod +x /docker-entrypoint-initdb.d/init-dbs.sh /usr/local/bin/healthcheck.sh && \
echo "$(date '+%d/%m/%Y - %H:%M:%S') | ***** BUILD COMPLETE *****"