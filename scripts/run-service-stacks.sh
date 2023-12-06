#!/bin/sh

SOURCE_PATH=~/poga-deploy

echo "Run parking-service stack..."
docker stack deploy -c $SOURCE_PATH/stacks/services/parking-service.yml --with-registry-auth services || { echo 'command failed' ; exit 1; }
echo "Done!"