#!/bin/bash

config_count=$(cat variable.json |  python3 -c "import sys, json; print(len(json.load(sys.stdin)['config']))")
# Initialize a variable to hold the dynamic services YAML
DYNAMIC_SERVICES=""

TEMPLATE_FILE="template-docker-compose.yml"
OUTPUT_FILE="docker-compose.yml"

cp "$TEMPLATE_FILE" "$OUTPUT_FILE"

for (( i=0; i<config_count; i++ )); do
    appium_port=$(cat variable.json |  python3 -c "import sys, json; print(json.load(sys.stdin)['config'][$i]['appium_port'])")
    wda_port=$(cat variable.json |  python3 -c "import sys, json; print(json.load(sys.stdin)['config'][$i]['wda_port'])")
    node_port=$(cat variable.json |  python3 -c "import sys, json; print(json.load(sys.stdin)['config'][$i]['node_port'])")
    platform_name=$(cat variable.json |  python3 -c "import sys, json; print(json.load(sys.stdin)['config'][$i]['platform_name'])")
    platform_version=$(cat variable.json |  python3 -c "import sys, json; print(json.load(sys.stdin)['config'][$i]['platform_version'])")
    udid=$(cat variable.json |  python3 -c "import sys, json; print(json.load(sys.stdin)['config'][$i]['udid'])")  
    device_name=$(cat variable.json |  python3 -c "import sys, json; print(json.load(sys.stdin)['config'][$i]['device_name'])")  

    #Create Appium Config file at appium-config/appium-$i.yml
    awk  -v appium_port="$appium_port" \
         -v wda_port="$wda_port" \
            '{gsub(/appium_port/, appium_port); gsub(/wda_port/, wda_port); print}' \
            appium-config/template-appium.yml > appium-config/appium-$i.yml
            
    # Create Node config file at appium-node/node-$i.toml
    awk  -v appium_port="$appium_port" \
         -v wda_port="$wda_port" \
         -v node_port="$node_port" \
        -v platform_name="$platform_name" \
        -v platform_version="$platform_version" \
        -v udid="$udid" \
        -v device_name="$device_name" \
            '{gsub(/{appium_port}/, appium_port);
             gsub(/{node_port}/, node_port); \
            gsub(/{platform_name}/, platform_name); \
            gsub(/{wda_port}/, wda_port); \
            gsub(/{platform_version}/, platform_version); \
            gsub(/{device_name}/, device_name); \
            gsub(/{udid}/, udid); print}' \
        appium-node/template-node.toml > appium-node/node-$i.toml

    # Create Appium Node Service for docker-compose
    service_name="appium-node-$i"
    SERVICE_YAML=$(cat <<EOF

  $service_name:
        image: appium-node
        depends_on:
        - builder
        - selenium-hub
        environment:
            SE_EVENT_BUS_HOST: selenium-hub
            SE_EVENT_BUS_PUBLISH_PORT: 4442
            SE_EVENT_BUS_SUBSCRIBE_PORT: 4443
            SE_OPTS: "--config /opt/selenium/config.toml"
        ports:
        - "$node_port:5555"
        volumes:
        - ./appium-node/node-$i.toml:/opt/selenium/config.toml
        networks:
        - selenium-grid
EOF
)
DYNAMIC_SERVICES+="$SERVICE_YAML"
done

OUTPUT_FILE=docker-compose.yml


sed -i '' '/# DYNAMIC_SERVICES_PLACEHOLDER/r /dev/stdin' "$OUTPUT_FILE" <<< "$DYNAMIC_SERVICES"