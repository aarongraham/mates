# Releasing new versions
Notes to myself on how to release this app

# Creating a new VPS in DigitalOcean
Some steps have not yet been automated and are listed below.

* Create VPS using the official DO docker droplet (Ubuntu)
* Point domains to IP in Route53
* `apt update && apt upgrade`
* `sudo systemctl reboot`
* Install nginx `apt install nginx`. The default nginx from DO repos should create /etc/nginx/conf.d/ and include this directory in the /etc/nginx/nginx.conf configuration. Check that this is the case as our deploy script depends on them. 
* `sudo rm /etc/nginx/sites-enabled/default && sudo rm /etc/nginx/sites-available/default`
* Configure firewall 
    `sudo ufw default deny incoming` 
    `sudo ufw default allow outgoing` 
    `sudo ufw status numbered`
    Delete all rules that are not ssh `sudo ufw delete X`
    `sudo ufw allow 'Nginx Full'`
* Install certbot `sudo apt install certbot python-certbot-nginx`
* Create certs `sudo certbot certonly --nginx` and follow prompts
* Login with docker `sudo docker login`
* Deploy app (See below)
* Test certs autorenew `sudo certbot renew --dry-run`

# Deploying a new version

`bin/prod/deploy.sh`

Ssh to the prod server and start new release
```
bin/prod/ssh.sh
sudo docker stop mates
sudo docker pull aarongraham1/mates
sudo docker run....(full command in bitbucket)
```

# Useful docker commands
`sudo docker ps --all`

`sudo docker rm mates`

`docker rm $(docker ps -a -q)`

`sudo docker system prune`

# Possible Future improvements
* Docker should connect through a unix socket
* Compression of pages and static assets
* Make webpage work nicely on mobile
* Automate more of the deployment, in particular starting the container. Docker-compose?
* Automate more of the server creation 
