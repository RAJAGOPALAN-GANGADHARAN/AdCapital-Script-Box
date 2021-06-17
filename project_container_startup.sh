#!/bin/bash

apt-get install -y git

curl -O https://downloads.gradle.org/distributions/gradle-2.1-bin.zip
unzip gradle-2.1-bin.zip -d /opt
rm gradle-2.1-bin.zip

GRADLE_HOME=/opt/gradle-2.1
PATH=$PATH:$GRADLE_HOME/bin

# Clone source repo from GitHub
git clone -b logging --single-branch https://github.com/Appdynamics/AD-Capital.git

# Gradle build
cd /AD-Capital; gradle build uberjar

cp -r /AD-Capital ${PROJECT}
echo "AD-Capital project copied to docker volume"

cp -r /opt/gradle-2.1 ${PROJECT}
echo "GRADLE project copied to docker volume"
