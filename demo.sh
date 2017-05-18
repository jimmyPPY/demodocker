#!/bin/bash
# 
######################################
# demo.sh
# Utilité: demo script for docker meeting
# Auteur: Jimmy PAEPEGAEY <jimmy.ppy@gmail.com>
# 
######################################
pause='read -p "################################################################"'
clear
set -x
# Installation
echo 'curl -fsSL https://get.docker.com/ | sh'
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
docker ps
$pause
docker run hello-world
docker ps
docker run -it busybox
echo 'ISOLATION DEMO'
ls
$pause
ps
$pause
ifconfig
$pause
exit
docker images
docker ps
$pause
echo 'docker rm'
echo 'docker rmi hello-world'
docker inspect busybox
$pause
docker run --name welcomedock busybox echo WELCOME IN DOCKER WORLD
$pause
docker start -a welcomedock
$pause
docker commit welcomedock mywelcomeimg
$pause
docker images
$pause
docker inspect mywelcomeimg
docker inspect welcomedock
docker history mywelcomeimg
$pause
clear
echo 'Docker Registry'
docker search --filter "is-official=true" a
$pause
docker tag mywelcomeimg jimmyppy/mywelcomeapp
#docker login
docker push jimmyppy/mywelcomeapp:v1
$pause
clear
echo 'Docker run option'
docker run -it -p 80:80 httpd /bin/bash
$pause
docker run -dit -p 80:80 httpd apachectl -D FOREGROUND
$pause
echo 'Run with volume mapping'
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
echo 'Le dockerfile'
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
echo 'Docker link option'
docker run  --name esmysql -e MYSQL_ROOT_PASSWORD=passe -d mysql/mysql-server:5.7
$pause
docker exec -it esmysql mysql -uroot -p -e "GRANT ALL PRIVILEGES ON *.* TO 'root@%';FLUSH PRIVILEGES;"
$pause
docker exec -it esmysql mysql -uroot -p
connect
SHOW DATABASES;
exit
$pause
docker exec -it esmysql mysql -uroot -p -e "GRANT ALL PRIVILEGES ON *.* TO 'root@%';FLUSH PRIVILEGES;"
docker run -dit --name myrunwebapp -p 80:80 --link esmysql:msql -v "$PWD:/var/www/html" mywebapp apachectl -D FOREGROUND
docker exec -it myrunwebapp /bin/bash -c env
$pause

clear
echo 'Docker Compose'
cat docker-compose.yml
$pause
docker-compose up
$pause
docker-compose ps
$pause
docker-compose down
$pause
clear
echo 'Docker Compose => Scalabilité'
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
echo 'Docker SWARM'
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
echo 'Docker Tools'
docker run -v "/var/run/docker.sock:/var/run/docker.sock" -p 9000:9000 portainer/portainer
$pause
docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
$pause
