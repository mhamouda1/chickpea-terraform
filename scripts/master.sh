#!/bin/bash
chmod 400 /home/ec2-user/.ssh/id_rsa
hostnamectl set-hostname master

sudo yum update -y
cd /tmp/scripts
bash install/git.sh
bash install/docker.sh
bash install/kubernetes.sh
bash install/docker-compose.sh
bash install/tmux.sh
bash install/vim.sh
bash install/aliases.sh
bash install/silver_searcher.sh
bash install/swap-memory.sh


# bash install/github.sh
# bash install/helm.sh

#install nginx-ingress-controller
# sudo helm install stable/nginx-ingress --name my-nginx --set rbac.create=true
