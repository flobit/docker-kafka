#!/bin/bash
env_params="";for i in `env`;do env_params="$env_params --override $i";done;
command="$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties $env_params"
$command
