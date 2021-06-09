#!/bin/bash

docker network create --driver bridge intranet
docker build -t webserver . --rm

docker run --name mysql -e MYSQL_ROOT_PASSWORD=root -d mysql:5.7
cd /home/ubuntu
git clone git@github.com:smallik123/SuiteCRM.git

sudo chmod -R 755 SuiteCRM

sudo mkdir logs

docker run --name "localhost" -d -e VIRTUAL_HOST=localhost --add-host="localhost:127.0.0.1" -p 80:80 -v /home/ubuntu/:/var/log/apache2 -v /home/ubuntu/SuiteCRM:/var/www/html --net intranet webserver

docker start $(docker ps -a -q -f status=exited)
