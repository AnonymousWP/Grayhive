#!/bin/bash

# This shell script stops the containers, then deletes them, including the images and volumes. In case executing this script doesn't work, allow it to execute: `sudo chmod +x ./clean_start.sh`

docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
docker rmi -f $(docker images -aq)
docker volume rm $(docker volume ls -q)
