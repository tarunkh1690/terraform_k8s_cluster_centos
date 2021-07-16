#!/bin/bash

sudo yum update -y
sudo cp /tmp/kubernetes.repo /etc/yum.repos.d/
sudo cp /tmp/k8s.repo /etc/sysctl.d/
sudo sysctl --system
sudo yum clean all
sudo yum install -y docker
sudo systemctl start docker.service
sudo yum install -y kubelet*1.18*  kubeadm*1.18* kubernetes-cni*0.8*
sudo mkdir -p $HOME/.aws/; sudo touch $HOME/.aws/config
sudo echo -e "[default]\nregion = ap-south-1" | sudo tee -a $HOME/.aws/config > /dev/null
aws s3 cp s3://k8s-join-master/kubeadm_join.sh /tmp/kubeadm_join.sh
sudo chmod +x /tmp/kubeadm_join.sh
sudo /tmp/kubeadm_join.sh
#sudo sed -i 's/\\//g' /tmp/kubeadm_join.sh
#sudo kubejoin=`cat /tmp/kubeadm_join.sh`
#sudo $kubejoin
