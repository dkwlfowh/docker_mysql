#!/bin/bash
## INSTALL DOCKER & UPDATE
yum -y install docker
yum -y update
systemctl start docker

## DOCKER PULL IMAGE
docker pull mysql
docker pull mysql:8.0.22
docker pull mysql:5.7

## Docker Image LIst
docker images > tmp/docker_list.txt

## Create Container MySQL
docker run --name mysql-5.7 -e MYSQL_ROOT_PASSWORD=root -d -p 3306:3306 mysql:5.7
#docker run --name mysql-5.7 --memory="2g" -e MYSQL_ROOT_PASSWORD=root -d -p 3306:3306 mysql:5.7
docker run --name mysql-8 -e MYSQL_ROOT_PASSWORD=root -d -p 3307:3306 mysql:8.0.22
#docker run --name mysql-8 --memory="2g" -e MYSQL_ROOT_PASSWORD=root -d -p 3307:3306 mysql:8.0.22
docker run --name mariadb-10.2 -e MYSQL_ROOT_PASSWORD=root -d -p 3308:3306 -t cytopia/mariadb-10.2


## ALIAS
echo "alias my5='docker exec -it mysql-5.7  /bin/bash'" >> ~/.bash_profile
echo "alias my8='docker exec -it mysql-8  /bin/bash'" >> ~/.bash_profile
echo "alias maria='docker exec -it mariadb-10.2  /bin/bash'" >> ~/.bash_profile


## TEST DATA CLONE & CP 
cd /root/
git clone https://github.com/datacharmer/test_db.git
docker cp /root/test_db mysql-5.7:/root/
docker cp /root/test_db mysql-8:/root/
docker cp /root/test_db mariadb-10.2:/root/

