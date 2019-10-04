#!/bin/bash
export $1
export $2
chmod 400 /home/ec2-user/.ssh/id_rsa
hostnamectl set-hostname "node$NODE-$HOSTNAME"
sudo bash -c "echo \"127.0.0.1 $(hostname)\" >> /etc/hosts"

#shortcut for development
sleep 80 && \
cd /tmp/remote && \
bash install/git.sh && \
bash install/docker.sh && \
bash install/kubernetes.sh && \
bash install/get_join_token.sh S3_BUCKET=$S3_BUCKET && \
bash install/swap-memory.sh
