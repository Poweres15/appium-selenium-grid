#!/bin/bash

appium --config appium-config/appium-0.yml > appium1.log 2>&1 &
appium --config appium-config/appium-1.yml > appium2.log 2>&1 &

docker-compose up -d 