#!/bin/sh

sudo apt-get install -y docker.io

sudo groupadd docker
sudo usermod -aG docker $USER
