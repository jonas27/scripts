export USERNAME="pi"
export HOMEPATH="/home/$USERNAME/"

# Change node name
sudo hostnamectl set-hostname piHome

# Use kubectl without sudo
mkdir -p $HOME/.kube && \
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config && \
sudo chown $USERNAME $HOME/.kube/config