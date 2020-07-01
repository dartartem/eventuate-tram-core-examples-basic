#! /bin/bash

set -e

export EVENTUATE_COMMON_VERSION="0.10.0.RELEASE"
export EVENTUATE_CDC_VERSION="0.7.0.RELEASE"

./mvnw clean compile

./mvnw -am -pl eventuate-tram-examples-in-memory test

docker-compose -f docker-compose-mysql-binlog.yml down -v

docker-compose -f docker-compose-mysql-binlog.yml up -d

./wait-for-services.sh localhost 8099

./mvnw -am  -pl eventuate-tram-examples-jdbc-kafka test

docker-compose -f docker-compose-mysql-binlog.yml down -v
