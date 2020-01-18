# Mates
Scripts to perform most actions can be found in the bin folder

#Certificates 
Currently the secret key is passed as a command line arg when starting the docker container (start command in bitbucket).

The cert will expire after 3 months (Early April). If you really want to renew the cert then create one manually locally with 

`certbot renew`

Or to create a new one 

`sudo certbot certonly --email agraham19@gmail.com -d mates.exfiddle.com --manual --preferred-challenges dns`

The copy the cert to the project 
`sudo cp /etc/letsencrypt/live/mates.exfiddle.com/fullchain.pem priv/cert/fullchain.pem`

And copy the secret key to the start command
`sudo cp /etc/letsencrypt/live/mates.exfiddle.com/privkey.pem`

TODO: Make the cert stuff better by installing certbot on the server and mounting the certs folder to the docker container. That way auto renew can be switched on

#Deploying a new version

`bin/publish.sh`

Ssh to the prod server and start new release
```
bin/prod/ssh.sh
sudo docker stop mates
sudo docker pull aarongraham1/mates
sudo docker run....(full command in bitbucket)
```

#Helpful docker commands
`sudo docker ps --all`
`sudo docker rm mates`
`docker rm $(docker ps -a -q)`
`sudo docker system prune`

#Future improvements
* Docker should connect through a unix socket
* Compression of pages and static assets
* Make more mobile friendly
