#!/bin/bash
# 
######################################
# demo.sh
# Utilité: demo script for docker meeting
# Auteur: Jimmy PAEPEGAEY <jimmy.ppy@gmail.com>
# 
######################################
pause='read -p "################################################################"'
BLUE='\033[0;34m'
NC='\033[0m'
clear
set -x
# Installation
echo -e "${BLUE}curl -fsSL https://get.docker.com/ | sh ${NC}"
#systemctl start docker
#systemctl status docker
#systemctl enable docker

systemctl status docker
$pause
docker ps
$pause
docker images
$pause
docker pull hello-world
docker images
$pause
docker run hello-world
docker ps -a
$pause
clear
echo -e "${BLUE}ISOLATION DEMO ${NC}"
echo -e "${BLUE}filesystem, processus, network ${NC}"
docker run -it busybox
ls /
$pause
ps
$pause
ifconfig
$pause
docker images
$pause
echo -e "${BLUE}docker rm ${NC}"
echo -e "${BLUE}docker rmi hello-world ${NC}"
$pause
clear
docker inspect busybox
$pause
clear
echo -e "${BLUE}Personalisation de conteneur ${NC}"
docker run --name welcomedock busybox echo WELCOME IN DOCKER WORLD
$pause
docker ps -a
docker start -a welcomedock
$pause
docker commit welcomedock mywelcomeimg
$pause
docker images
$pause
docker history mywelcomeimg
$pause
clear
echo -e "${BLUE}Docker Registry ${NC}"
docker search --filter "is-official=true" a
$pause
docker tag mywelcomeimg jimmyppy/mywelcomeapp:v1
#docker login
docker push jimmyppy/mywelcomeapp:v1
$pause
clear
echo -e "${BLUE}Docker run option ${NC}"
docker run -it -p 80:80 httpd /bin/bash
$pause
docker run -dit -p 80:80 httpd apachectl -D FOREGROUND
$pause
echo -e "${BLUE}Run with volume mapping ${NC}"
cd $HOME/demodocker/httpd/
ls
$pause
docker run -dit --name volmapping -p 80:80 -v "$PWD:/usr/local/apache2/htdocs" httpd apachectl -D FOREGROUND
$pause
docker exec -it volmapping /bin/bash -c ls /usr/local/apache2/htdocs
$pause
docker stop volmapping
cd $HOME/demodocker/httpd/
clear
echo -e "${BLUE}Le dockerfile ${NC}"
cat dockerfile.yml
$pause
docker build -t myhttpd .
$pause
docker images
$pause
docker run -dit -p 8080 --name myhttpdapp "$PWD":/usr/local/apache2/htdocs/ myhttpd
$pause

clear
cd $HOME/demodocker/webapp/
echo -e "${BLUE}Docker link option ${NC}"
docker run  --name esmysql -e MYSQL_ROOT_PASSWORD=passe -d mysql/mysql-server:5.7
$pause
docker exec -it esmysql mysql -uroot -p -e "GRANT ALL PRIVILEGES ON *.* TO 'root@%';FLUSH PRIVILEGES;"
$pause
echo -e "${BLUE}Check 
 ${NC}"
docker exec -it esmysql mysql -uroot -p
connect
SHOW DATABASES;
$pause
docker exec -it esmysql mysql -uroot -p -e "GRANT ALL PRIVILEGES ON *.* TO 'root@%';FLUSH PRIVILEGES;"
docker run -dit --name myrunwebapp -p 80:80 --link esmysql:msql -v "$PWD:/var/www/html" mywebapp apachectl -D FOREGROUND
docker exec -it myrunwebapp /bin/bash -c env
$pause

clear
echo -e "${BLUE}Docker Compose ${NC}"
cat docker-compose.yml
$pause
docker-compose up
$pause
docker-compose ps
$pause
docker-compose down
$pause
clear
echo -e "${BLUE}Docker Compose => Scalabilité ${NC}"
cd $HOME/demodocker/HAdemo/
cat docker-compose.yml
$pause
docker-compose up -d
$pause
docker-compose ps
$pause
docker-compose logs 
$pause
docker-compose scale web=3
$pause
docker-compose logs 
$pause

clear
echo -e "${BLUE}Docker SWARM ${NC}"
docker node ls
$pause
docker service create --replicas 1 --name helloworld busybox ping docker.com
$pause
docker service inspect --pretty helloworld
$pause
docker service ps helloworld
$pause
docker service scale helloworld=5
$pause
docker service ps helloworld
$pause
docker service rm helloworld



clear
echo -e "${BLUE}Docker Tools ${NC}"
docker run -v "/var/run/docker.sock:/var/run/docker.sock" -p 9000:9000 portainer/portainer
$pause
docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
$pause
