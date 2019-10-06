#hmmm, why is this not working?
sudo modprobe br_netfilter
sudo echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
#install kubernetes
sudo bash -c "cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
   https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF"
sudo yum update -y
sudo yum install kubelet-1.15.4 kubeadm-1.15.4 kubectl-1.15.4 -y
sudo systemctl enable kubelet
