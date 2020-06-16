#!/bin/bash

#Create custom network

echo "creating custom docker bridge network"
sudo docker network create custom-net

echo "Creating nginx image and running container"
sudo docker pull nginx

# Configuring nginx to serve a simple web page 
echo "Hello Arca!" > index.html

sudo docker run --name nginx-server --network custom-net -v $PWD:/usr/share/nginx/html:ro -p 80:80 -d nginx

#Kibana

echo "Creating Kibana image and running container"

sudo docker pull Kibana:6.4.2

sudo docker run --name kibana --network custom-net -p 5601:5601 -d kibana:6.4.2


#mysql
echo "Creating mysql  image and running container"

sudo docker pull mysql

sudo docker run --name mysql-server --network custom-net -e MYSQL_ROOT_PASSWORD=password01 -d mysql

echo "required containers running"

sudo docker ps







