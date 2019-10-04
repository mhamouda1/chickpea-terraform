#install helm
chmod 700 ruby-docker-app/get_helm.sh
./ruby-docker-app/get_helm.sh
cd ~/ruby-docker-app
kubectl create -f rbac-config.yml #tiller
helm init --service-account tiller --history-max 200 #tiller
helm init --service-account tiller --wait --override spec.selector.matchLabels.'name'='tiller',spec.selector.matchLabels.'app'='helm' --output yaml | sed 's@apiVersion: extensions/v1beta1@apiVersion: apps/v1@' | kubectl apply -f -
