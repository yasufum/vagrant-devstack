#!/bin/sh

sudo apt install -y docker.io

sudo groupadd docker
sudo usermod -aG docker $USER
