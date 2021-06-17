curl https://raw.githubusercontent.com/RAJAGOPALAN-GANGADHARAN/AdCapital-Script-Box/main/adcapital_load_startup.sh -o adcapital_load_startup.sh
curl https://raw.githubusercontent.com/RAJAGOPALAN-GANGADHARAN/AdCapital-Script-Box/main/adcapital_tomcat_startup.sh -o adcapital_tomcat_startup.sh
curl https://raw.githubusercontent.com/RAJAGOPALAN-GANGADHARAN/AdCapital-Script-Box/main/appdynamics_container_config.sh -o appdynamics_container_config.sh
curl https://raw.githubusercontent.com/RAJAGOPALAN-GANGADHARAN/AdCapital-Script-Box/main/project_container_startup.sh -o project_container_startup.sh

cp adcapital_load_startup.sh /appdynamics/adcapital_load_startup.sh
cp adcapital_tomcat_startup.sh /appdynamics/adcapital_tomcat_startup.sh
cp appdynamics_container_config.sh /appdynamics/appdynamics_container_config.sh
cp project_container_startup.sh /appdynamics/project_container_startup.sh



# Copy AppDynamics Agent to shared volume
echo "Copying App Server Agent to volume: ${APPD_DIR}"
cp -R /agents/javaagent ${APPD_DIR}/
