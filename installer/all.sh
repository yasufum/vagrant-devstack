#!/bin/bash

# Run this script inside the VM

HOSTIP=${VAGRANT_PRIVATE_IP0}
BASE_DIR=$(cd $(dirname $0); pwd)

if [ ! $HOME = '/opt/stack' ]; then
    echo "Error: You should run this script as 'stack' user!"
    exit
fi

# Basic packages
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y python3 python3-dev
sudo apt-get install -y python3-pip bridge-utils
sudo apt-get install -y git git-review

echo "export PATH=\$HOME/.local/bin:\$PATH:/sbin" >> ${HOME}/.bashrc

echo "Install python3"
. ${BASE_DIR}/python3.sh


echo "Install docker"
. ${BASE_DIR}/docker.sh


echo "Install vim8, vim-plug and lang servers"
. ${BASE_DIR}/vim8.sh
. ${BASE_DIR}/vim-plug.sh
. ${BASE_DIR}/lang-servers.sh


echo "Install devstack and related packages"
. ${BASE_DIR}/devstack.sh


echo "Install optional tools"
. ${BASE_DIR}/ops-tools.sh
git clone https://github.com/yasufum/bash_utils.git
echo "source ${HOME}/bash_utils/wf.sh" >> ${HOME}/.bashrc

echo "Setup tacker"
. ${BASE_DIR}/setup_tacker.sh

echo "Done!"
