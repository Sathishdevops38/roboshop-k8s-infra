#!/bin/bash
growpart /dev/nvme0n1 4
lvextend -L +30G /dev/mapper/RootVG-varVol
xfs_growfs /var

#install docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

#install kubectl
 curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
 sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

 #install eksctl
 ARCH=amd64
 PLATFORM=$(uname -s)_$ARCH
 curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
 tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
 sudo mv /tmp/eksctl /usr/local/bin