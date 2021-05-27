#!/bin/bash

SCALA_VERSION=2.13
KAFKA_VERSION=2.8.0
PACKAGE_NAME=kafka_$SCALA_VERSION-$KAFKA_VERSION
ARCHIVE_NAME="$PACKAGE_NAME.tgz"



clean(){
	rm -rf $PACKAGE_NAME
	rm -f Dockerfile
}
prepare(){
    #下载压缩包
    if [ ! -f $ARCHIVE_NAME ]
    then
	    curl -Lo $ARCHIVE_NAME  "https://downloads.apache.org/kafka/$KAFKA_VERSION/$ARCHIVE_NAME"
    fi
}
#组装Dockerfile
build(){
    cp Dockerfile.sample Dockerfile
    sed -i "s/\${DISTRO_NAME}/${PACKAGE_NAME}/g" Dockerfile
    docker build -t kafka:$KAFKA_VERSION .
}

if [ "$1" == "clean" ]
then
	clean
    exit 0
fi

prepare
build
clean
