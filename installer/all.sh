#!/bin/bash

# Run this script inside the VM

BASE_DIR=/vagrant/installer
UTIL_DIR=/vagrant/util

echo "PATH=$PATH:/sbin" >> ${HOME}/.bashrc

echo "Install docker"
source ${BASE_DIR}/docker.sh


echo "Install vim8, vim-plug and lang servers"
source ${BASE_DIR}/vim8.sh
source ${BASE_DIR}/vim-plug.sh
source ${BASE_DIR}/lang-servers.sh

#echo "Install neovim and dein for management vim packages"
#source ${BASE_DIR}/nvim.sh
#source ${BASE_DIR}/dein.sh


echo "Install devstack and related packages"
source ${BASE_DIR}/devstack.sh


echo "Install optional tools"
source ${BASE_DIR}/ops-tools.sh
git clone https://github.com/yasufum/bash_utils.git
echo "source ${HOME}/bash_utils/wf.sh" >> ${HOME}/.bashrc

echo "Done!"
