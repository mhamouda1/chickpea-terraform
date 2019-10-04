export $1
#join with token
sudo aws s3 cp s3://$S3_BUCKET/kubernetes_join.txt kubernetes_join.txt
sudo $(cat kubernetes_join.txt)
