#!/bin/bash


docker-compose down

kill -9 $(lsof -t -i :4723)
kill -9 $(lsof -t -i :4724)
