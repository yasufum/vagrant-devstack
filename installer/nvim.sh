#!/bin/sh

# install nvim
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update -y
sudo apt install neovim -y

sudo apt install python3-dev python3-pip -y
pip3 install neovim

pip3 install jedi

pip3 install -U pip3
