#!/bin/bash

# apt install stuff
sudo apt install -y git chrome-gnome-shell tilix dconf-editor xdotool

# apt install stuff
sudo snap install -y code --classic

# do synbolic link stuff
ln -s $HOME/git/scripts $HOME/scripts

# make all scripts executable
chmod +x $HOME/git/scripts/*.sh
