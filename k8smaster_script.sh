#!/bin/bash

sudo yum update -y
sudo yum clean all
sudo cp /tmp/kubernetes.repo /etc/yum.repos.d/
sudo cp /tmp/k8s.conf /etc/sysctl.d/
sudo sysctl --system
sudo yum install -y docker
sudo yum install -y kubelet-1.18*  kubeadm-1.18* kubectl-1.18* kubernetes-cni
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo kubeadm init --ignore-preflight-errors=NumCPU >> /tmp/kubeadminit.log
sudo systemctl enable kubectl
sudo cat /tmp/kubeadminit.log | tail -n2 > /tmp/kubeadm_join.sh
mkdir -p $HOME/.aws/;  touch $HOME/.aws/config
echo -e "[default]\nregion = ap-south-1" |  tee -a $HOME/.aws/config > /dev/null
aws s3 cp /tmp/kubeadm_join.sh s3://k8s-join-master/

# kubectl configuration
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
#sleep 120
#export kubever=$(kubectl version | base64 | tr -d '\n') |  tee -a /tmp/output > /dev/null
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=1.18"
#kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml

