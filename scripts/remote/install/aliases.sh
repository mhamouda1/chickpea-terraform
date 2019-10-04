#make administration easier
sudo bash -c "echo \"alias kga='sudo kubectl get all'\"" >> ~/.bashrc && source ~/.bashrc
sudo bash -c "echo \"alias kgaan='sudo kubectl get all --all-namespaces'\"" >> ~/.bashrc && source ~/.bashrc
sudo bash -c "echo \"alias k='kubectl'\"" >> ~/.bashrc && source ~/.bashrc
sudo bash -c "echo \"alias kgn='kubectl get nodes'\"" >> ~/.bashrc && source ~/.bashrc
sudo bash -c "echo \"alias kgp='kubectl get pods'\"" >> ~/.bashrc && source ~/.bashrc
sudo bash -c "echo \"alias kgd='kubectl get deployments'\"" >> ~/.bashrc && source ~/.bashrc
sudo bash -c "echo \"alias kgs='kubectl get services'\"" >> ~/.bashrc && source ~/.bashrc
sudo bash -c "echo \"alias kgi='kubectl get ingresses'\"" >> ~/.bashrc && source ~/.bashrc
sudo bash -c "echo \"alias kgcm='kubectl get configmaps'\"" >> ~/.bashrc && source ~/.bashrc
