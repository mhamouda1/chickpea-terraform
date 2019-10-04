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
sudo yum install kubelet kubeadm kubectl -y
sudo systemctl enable kubelet
sudo bash -c "echo \"127.0.0.1 $(hostname)\" >> /etc/hosts"
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors="NumCPU"
#kubelet
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
#flannel
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#create token
sudo kubeadm token create --print-join-command --ttl=72h > kubernetes_join.txt
sudo aws s3 cp kubernetes_join.txt s3://$S3_BUCKET
