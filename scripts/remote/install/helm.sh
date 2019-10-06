#install helm
#git clone the project
cd ~
git clone https://github.com/mhamouda1/ruby-docker-app
chmod 700 ruby-docker-app/get_helm.sh
./ruby-docker-app/get_helm.sh
cd ~/ruby-docker-app
#untaint master node
k taint node master node-role.kubernetes.io/master:NoSchedule-
kubectl create -f rbac-config.yml #tiller
helm init --service-account tiller --history-max 200 #tiller


#bug with kubernetes 1.16
#helm init --service-account tiller --wait --override spec.selector.matchLabels.'name'='tiller',spec.selector.matchLabels.'app'='helm' --output yaml | sed 's@apiVersion: extensions/v1beta1@apiVersion: apps/v1@' | kubectl apply -f -
