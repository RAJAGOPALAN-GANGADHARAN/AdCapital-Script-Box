# Pick up AppDynamics Agent configuration from shared volume (APPD_DIR)
# Environment variables APPD_JAVAAGENT and APPD_PROPERTIES are used to configure AppDynamics agent

if [ -e ${APPD_DIR}/javaagent/javaagent.jar ]; then
  export APPD_JAVAAGENT=" -javaagent:${APPD_DIR}/javaagent/javaagent.jar"
  echo "APPD_JAVAAGENT: ${APPD_JAVAAGENT}"

  # AppDynamics connection paramters set via environment varibles
  if [ -z "${CONTROLLER_HOST}" ]; then echo "APPD_CONTR_HOST not defined" && CONFIG_ERROR=true; fi
  if [ -z "${CONTROLLER_PORT}" ]; then echo "APPD_CONTR_PORT not defined" && CONFIG_ERROR=true; fi
  if [ -z "${CONTROLLER_SSL_ENABLED}" ]; then echo "APPD_CONTR_SSL not defined" && CONFIG_ERROR=true; fi
  if [ -z "${ACCOUNT_NAME}" ]; then echo "APPD_ACCOUNT_NAME not defined" && CONFIG_ERROR=true; fi
  if [ -z "${ACCESS_KEY}" ]; then echo "APPD_ACCESS_KEY not defined" && CONFIG_ERROR=true; fi
  if [ -z "${APPLICATION_NAME}" ]; then echo "APPD_APP_NAME not defined" && CONFIG_ERROR=true; fi
  if [ -z "${APPDYNAMICS_AGENT_NODE_NAME}" ]; then echo "APPD_NODE_NAME not defined" && CONFIG_ERROR=true; fi
  if [ -z "${APPDYNAMICS_AGENT_TIER_NAME}" ]; then echo "APPD_TIER_NAME not defined" && CONFIG_ERROR=true; fi

  if [ ! "${CONFIG_ERROR}" == "true" ]; then
    # Export environment variable with AppDynamics Agent properties
    export APPD_PROPERTIES="\
     -Dappdynamics.controller.hostName=${CONTROLLER_HOST}\
     -Dappdynamics.controller.port=${CONTROLLER_PORT}\
     -Dappdynamics.controller.ssl.enabled=${CONTROLLER_SSL_ENABLED}\
     -Dappdynamics.agent.accountName=${ACCOUNT_NAME}\
     -Dappdynamics.agent.accountAccessKey=${ACCESS_KEY}\
     -Dappdynamics.agent.applicationName=${APPLICATION_NAME}\
     -Dappdynamics.agent.tierName=${APPDYNAMICS_AGENT_TIER_NAME}\
     -Dappdynamics.agent.nodeName=${APPDYNAMICS_AGENT_NODE_NAME}\
     -Dappdynamics.analytics.agent.url=http://monitor:9090/v2/sinks/bt"
    echo "APPD_PROPERTIES: ${APPD_PROPERTIES}"
  else
    echo "AppDynamics configuration error - Running without monitoring enabled"
  fi

else
  echo "AppDynamics Agent not found - Running without monitoring enabled"
fi
