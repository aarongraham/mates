#!/usr/bin/env bash

echo "Deploying to mates.exfiddle.com"

bin/prod/publish.sh

ssh root@mates.exfiddle.com -i ~/.ssh/digitalocean 'mkdir -p mates'
scp -r -i ~/.ssh/digitalocean infra/ root@mates.exfiddle.com:mates/
ssh root@mates.exfiddle.com -i ~/.ssh/digitalocean './mates/infra/deploy-here.sh'