#!/bin/bash

# Run this script inside the VM

if [ ! $HOME = '/opt/stack' ]; then
    echo "Error: You should run this script as 'stack' user!"
    exit
fi

BASE_DIR=/vagrant/installer
UTIL_DIR=/vagrant/util

echo "export PATH=\$HOME/.local/bin:\$PATH:/sbin" >> ${HOME}/.bashrc

echo "Install python3"
source ${BASE_DIR}/python3.sh


echo "Install docker"
source ${BASE_DIR}/docker.sh


echo "Install vim8, vim-plug and lang servers"
source ${BASE_DIR}/vim8.sh
source ${BASE_DIR}/vim-plug.sh
source ${BASE_DIR}/lang-servers.sh


echo "Install devstack and related packages"
source ${BASE_DIR}/devstack.sh


echo "Install optional tools"
source ${BASE_DIR}/ops-tools.sh
git clone https://github.com/yasufum/bash_utils.git
echo "source ${HOME}/bash_utils/wf.sh" >> ${HOME}/.bashrc

echo "Setup tacker"
source ${BASE_DIR}/setup_tacker.sh

echo "Done!"
