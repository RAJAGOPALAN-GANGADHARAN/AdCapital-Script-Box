#!/bin/bash

apt-get update
apt-get install -y git

#DOCKERIZE
DOCKERIZE_VERSION=v0.5.0
wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Gradle
curl -O -L http://downloads.gradle.org/distributions/gradle-2.1-bin.zip
unzip gradle-2.1-bin.zip -d /opt/
rm gradle-2.1-bin.zip
GRADLE_HOME=/opt/gradle-2.1
PATH=$PATH:$GRADLE_HOME/bin

# Clone source repo from GitHub
git clone https://github.com/Appdynamics/AD-Capital-Load.git

LOAD_GEN_PROJECT=/AD-Capital-Load
cd ${LOAD_GEN_PROJECT}; gradle distZip
unzip ${LOAD_GEN_PROJECT}/build/distributions/load-generator.zip -d /
chmod +x ${LOAD_GEN_PROJECT}/bin/*

# 1st param to LoadRunner call
if [ -z "${PORTAL_HOST}" ]; then
        export PORTAL_HOST="portal";
fi

# 2nd param to LoadRunner call
if [ -z "${PROCESSOR_HOST}" ]; then
        export PROCESSOR_HOST="processor";
fi

# Service dependencies
dockerize -wait tcp://${PORTAL_HOST}:8080 \
          -wait tcp://${PROCESSOR_HOST}:8083 \
          -wait-retry-interval ${RETRY} -timeout ${TIMEOUT} || exit $?

${LOAD_GEN_PROJECT}/bin/AD-Capital-Load ${PORTAL_HOST} ${PROCESSOR_HOST}
