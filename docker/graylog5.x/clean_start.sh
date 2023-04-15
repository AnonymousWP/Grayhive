#!/bin/bash

# In case executing this script doesn't work, allow it to execute: `sudo chmod +x ./clean_start.sh`

# Remove containers related to the Docker Compose file
docker compose down --rmi all

# Remove networks related to the Docker Compose file
for network in $(docker network ls --filter name='graylog' --format '{{.Name}}'); do
  docker network rm $network
done

# Remove volumes related to the Docker Compose file
for volume in $(docker volume ls --filter name='graylog' --format '{{.Name}}'); do
  docker volume rm $volume
done

# Remove images related to the Docker Compose file
for image in $(docker images | grep 'graylog\|mongo\|opensearchproject' | awk '{print $3}'); do
  docker rmi -f $image
done

echo -e "\033[1mAll Docker resources related to the Docker Compose file have been removed.\033[0m"
