#!/bin/bash

# Fixes some issues concerning local variables and cgroups
export LC_ALL=C

# Turn swap off
sudo dphys-swapfile swapoff && sudo dphys-swapfile uninstall && sudo update-rc.d dphys-swapfile remove

# give all cgroups access to cpuset and memory. Important for K3s
sudo sed -i '$a cgroup_enable=cpuset cgroup_enable=memory' /boot/cmdline.txt

# Install docker
curl -s https://download.docker.com/linux/raspbian/gpg | sudo apt-key add -
echo "deb [arch=armhf] https://download.docker.com/linux/raspbian stretch edge" | sudo tee /etc/apt/sources.list.d/socker.list

# Install kubeadm
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -q && sudo apt-get install -y kubeadm kubectl kubelet
sudo reboot