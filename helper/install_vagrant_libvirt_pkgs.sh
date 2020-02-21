#!/bin/sh

sudo apt-get build-dep vagrant ruby-libvirt -y
sudo apt install qemu libvirt-bin ebtables dnsmasq-base -y
sudo apt install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev -y

vagrant plugin install vagrant-libvirt
