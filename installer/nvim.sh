#!/bin/sh

sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update -y
sudo apt-get install neovim -y
sudo apt-get install python3-dev python3-pip -y

pip3 install -U pip3