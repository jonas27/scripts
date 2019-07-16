#!/bin/bash

# Fixes some issues concerning local variables and cgroups
export LC_ALL=C

# Allow for all releases in buster release
sudo apt-get update --allow-releaseinfo-change

# Turn swap off
sudo dphys-swapfile swapoff && sudo dphys-swapfile uninstall && sudo update-rc.d dphys-swapfile remove

# give all cgroups access to cpuset and memory. Important for K3s
sudo sed -i '$a cgroup_enable=cpuset cgroup_enable=memory' /boot/cmdline.txt

# Install docker did not work
# curl -s https://download.docker.com/linux/raspbian/gpg | sudo apt-key add -
# echo "deb [arch=armhf] https://download.docker.com/linux/raspbian stretch edge" | sudo tee /etc/apt/sources.list.d/socker.list
# sudo apt update -q
# sudo apt install -y docker-ce=18.09.0~3-0~raspbian-stretch --allow-downgrades --no-install-recommends
# echo "docker-ce hold" | sudo dpkg --set-selections
# sudo usermod pi -aG docker
# try change from 18.06.1~ce~3-0~raspbian to 18.09.0~3-0~raspbian-stretch
# did not work
sudo apt-get update
apt-get install -y apt-transport-https ca-certificates software-properties-common
curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
echo "deb https://download.docker.com/linux/raspbian/ stretch stable" > /etc/apt/sources.list.d/docker.list
apt -y install  docker-ce
systemctl enable docker.service
systemctl start docker.service

# Install kubeadm
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update -q && sudo apt install -y kubeadm kubectl kubelet

# sudo reboot