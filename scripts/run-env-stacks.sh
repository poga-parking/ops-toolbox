#!/bin/sh

SOURCE_PATH=~/poga-deploy

echo "Run logging stack..."
docker stack deploy -c $SOURCE_PATH/stacks/logging.yml logging || { echo 'command failed' ; exit 1; }
echo "Done!"
echo "Run monitoring stack..."
docker stack deploy -c $SOURCE_PATH/stacks/monitoring.yml monitoring || { echo 'command failed' ; exit 1; }
echo "Done!"