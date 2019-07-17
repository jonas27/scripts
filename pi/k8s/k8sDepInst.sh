#!/bin/bash

# Fixes some issues concerning local variables and cgroups
export LC_ALL=C

# Allow for all releases in buster release
# sudo apt-get update --allow-releaseinfo-change

# Turn swap off
sudo dphys-swapfile swapoff && sudo dphys-swapfile uninstall && sudo update-rc.d dphys-swapfile remove

# give all cgroups access to cpuset and memory. Important for K3s
sudo sed -i '$a cgroup_enable=cpuset cgroup_enable=memory' /boot/cmdline.txt

# Install docker/kubeadm dependencies
sudo apt-get install apt-transport-https ca-certificates software-properties-common -y

# Install docker 
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
# Give user docker rights
sudo usermod -aG docker pi
# Import Docker CPG key
sudo curl https://download.docker.com/linux/raspbian/gpg
# Setup the Docker Repo.
sudo sed -i '$a deb https://download.docker.com/linux/raspbian/ stretch stable' /etc/apt/sources.list
# Fetch and upgrade
sudo apt-get update
sudo apt-get upgrade -y
# Init docker
sudo systemctl start docker.service

# Install k8s
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update -q && sudo apt install -y kubeadm kubectl kubelet

sudo reboot