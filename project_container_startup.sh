#!/bin/bash

curl https://raw.githubusercontent.com/RAJAGOPALAN-GANGADHARAN/AdCapital-Script-Box/main/adcapital_load_startup.sh -o adcapital_load_startup.sh
curl https://raw.githubusercontent.com/RAJAGOPALAN-GANGADHARAN/AdCapital-Script-Box/main/adcapital_tomcat_startup.sh -o adcapital_tomcat_startup.sh
curl https://raw.githubusercontent.com/RAJAGOPALAN-GANGADHARAN/AdCapital-Script-Box/main/appdynamics_container_config.sh -o appdynamics_container_config.sh
curl https://raw.githubusercontent.com/RAJAGOPALAN-GANGADHARAN/AdCapital-Script-Box/main/appdynamics_container_startup.sh -o appdynamics_container_startup.sh

cp adcapital_load_startup.sh /appdynamics/adcapital_load_startup.sh
cp adcapital_tomcat_startup.sh /project/adcapital_tomcat_startup.sh
cp appdynamics_container_config.sh /appdynamics/appdynamics.sh
cp appdynamics_container_startup.sh /appdynamics/appdynamics_container_startup.sh


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
