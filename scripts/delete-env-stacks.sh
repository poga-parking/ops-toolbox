#!/bin/sh

SOURCE_PATH=~/poga-deploy

echo "Remove logging stack..."
docker stack rm logging || { echo 'command failed' ; exit 1; }
echo "Done!"
echo "Remove monitoring stack..."
docker stack rm monitoring || { echo 'command failed' ; exit 1; }
echo "Done!"