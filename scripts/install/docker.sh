#docker pre-reqs
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
#enable br_netfilter for communication
sudo modprobe br_netfilter
sudo echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
#install docker
sudo yum install docker -y
sudo bash -c 'cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF'
sudo yum install tc -y
sudo systemctl daemon-reload
sudo systemctl enable docker --now
sudo service docker start
