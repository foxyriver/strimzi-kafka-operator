#!/bin/bash

# volume for saving Kafka server logs
export ZOOKEEPER_VOLUME="/tmp/zookeeper/"
# base name for Kafka server logs dir
export ZOOKEEPER_DATA_BASE_NAME="data"

echo "ZOOKEEPER_ID=$ZOOKEEPER_ID"
# writing Zookeeper server id into "myid" file
mkdir $ZOOKEEPER_VOLUME$ZOOKEEPER_DATA_BASE_NAME-$ZOOKEEPER_ID
echo $ZOOKEEPER_ID > "$ZOOKEEPER_VOLUME$ZOOKEEPER_DATA_BASE_NAME-$ZOOKEEPER_ID/myid"

# environment variables substitution in the server configuration template file
envsubst < $KAFKA_HOME/config/zookeeper.properties.template > /tmp/zookeeper.properties

BASE=$(dirname $0)
$BASE/zookeeper_pre_run.py /tmp/zookeeper.properties

# dir for saving application logs
export LOG_DIR=$ZOOKEEPER_VOLUME"/logs/"

# starting Zookeeper with final configuration
exec $KAFKA_HOME/bin/zookeeper-server-start.sh /tmp/zookeeper.properties