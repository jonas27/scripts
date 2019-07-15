#!/bin/bash

# Fixes some issues concerning local variables and cgroups
export LC_ALL=C

# Allow for all releases in buster release
sudo apt-get update --allow-releaseinfo-change

# Turn swap off
sudo dphys-swapfile swapoff && sudo dphys-swapfile uninstall && sudo update-rc.d dphys-swapfile remove

# give all cgroups access to cpuset and memory. Important for K3s
sudo sed -i '$a cgroup_enable=cpuset cgroup_enable=memory' /boot/cmdline.txt

# Install docker
curl -s https://download.docker.com/linux/raspbian/gpg | sudo apt-key add -
echo "deb [arch=armhf] https://download.docker.com/linux/raspbian stretch edge" | sudo tee /etc/apt/sources.list.d/socker.list
sudo apt update -q
sudo apt install -y docker-ce=18.06.0~ce~3-0~raspbian --allow-downgrades
echo "docker-ce hold" | sudo dpkg --set-selections
sudo usermod pi -aG docker

# Install kubeadm
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update -q && sudo apt install -y kubeadm kubectl kubelet

# sudo reboot