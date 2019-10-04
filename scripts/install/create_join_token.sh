export $1
#create token
sudo kubeadm token create --print-join-command --ttl=72h > kubernetes_join.txt
sudo aws s3 cp kubernetes_join.txt s3://$S3_BUCKET
