#!/bin/bash
# 
######################################
# demo.sh
# Utilité: demo script for docker meeting
# Auteur: Jimmy PAEPEGAEY <jimmy.ppy@gmail.com>
# 
######################################
pause='read -p "Press_enter_to_continu" '
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
docker ps
$pause
docker run hello-world
docker ps
docker run busybox
docker images
docker ps
$pause
docker run -it busybox 
$pause