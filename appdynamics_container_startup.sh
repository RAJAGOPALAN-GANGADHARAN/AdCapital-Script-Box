# Copy AppDynamics Agent to shared volume
echo "Copying App Server Agent to volume: ${APPD_DIR}"
cp -R /agents/javaagent ${APPD_DIR}/
