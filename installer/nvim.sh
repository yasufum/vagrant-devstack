#!/bin/sh

# install nvim
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update -y
sudo apt-get install neovim -y

sudo apt-get install python3-dev python3-pip -y
sudo pip install neovim
sudo pip3 install neovim

sudo pip install jedi
sudo pip3 install jedi

pip3 install -U pip3
