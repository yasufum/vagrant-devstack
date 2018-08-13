#!/bin/bash

# Run this script inside the VM

BASE_DIR=/vagrant/installer
UTIL_DIR=/vagrant/util

echo "Install devstack and related packages"
source ${BASE_DIR}/devstack.sh

echo "Install neovim"
source ${BASE_DIR}/nvim.sh

echo "Install dein for management vim packages"
source ${BASE_DIR}/dein.sh

echo "Install docker"
source ${BASE_DIR}/docker.sh

echo "PATH=$PATH:/sbin" >> ${HOME}/.bashrc
echo "source ${UTIL_DIR}/wf.sh" >> ${HOME}/.bashrc

echo "Done!"
