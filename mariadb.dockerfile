#FROM mariadb:10.5.13
FROM mariadb:lts
MAINTAINER boredazfcuk
# mariadb_version not used, just increment to force a rebuild
ARG mariadb_version="10.9.3-jammy"
RUN echo "$(date '+%d/%m/%Y - %H:%M:%S') | ***** BUILD STARTED FOR MARIADB *****" && \
   apt-get update && \
   apt-get install -y tzdata netcat && \
echo "$(date '+%d/%m/%Y - %H:%M:%S') | ***** BUILD COMPLETE *****"

COPY --chmod=0755 init-nextclouddb.sh /docker-entrypoint-initdb.d/init-nextclouddb.sh
COPY --chmod=0755 healthcheck.sh /usr/local/bin/healthcheck.sh
