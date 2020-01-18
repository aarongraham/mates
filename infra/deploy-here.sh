#!/usr/bin/env bash

set -e

echo "Deploying on ${HOSTNAME}. Note this script wont actually start the new container. That needs to be done manually. lol"

echo "Replacing Nginx config"
sudo cp mates/infra/mates.exfiddle.com.conf /etc/nginx/conf.d/

echo "Getting latest docker container"
sudo docker pull aarongraham1/mates

echo "Restarting Nginx"
sudo systemctl restart nginx.service

echo "You now need to stop and start docker using the start command in bitwarden."
