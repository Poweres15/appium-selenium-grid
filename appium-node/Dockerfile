# appium-node/Dockerfile

# Base image for Selenium node
FROM selenium/node-docker:4.13.0

# Expose the port for the Selenium node
EXPOSE 5555

# Use CMD to start the Selenium node with the config file
CMD ["java", "-jar", "/opt/selenium/selenium-server.jar", "node", "--config", "/opt/selenium/config.toml" ]