FROM mariadb
MAINTAINER boredazfcuk

RUN echo "$(date '+%d/%m/%Y - %H:%M:%S') | ***** BUILD STARTED *****" && \
   apt-get update && \
   apt-get install -y tzdata

COPY init-dbs.sh /docker-entrypoint-initdb.d/init-dbs.sh
COPY healthcheck.sh /usr/local/bin/healthcheck.sh

RUN echo "$(date '+%d/%m/%Y - %H:%M:%S') | Set scripts to be executable" && \
   chmod +x /docker-entrypoint-initdb.d/init-dbs.sh /usr/local/bin/healthcheck.sh && \
echo "$(date '+%d/%m/%Y - %H:%M:%S') | ***** BUILD COMPLETE *****"