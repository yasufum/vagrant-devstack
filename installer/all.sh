#!/bin/bash

BASE_DIR=/vagrant/installer
UTILS_DIR=/vagrant/util

echo "Install devstack and related packages"
source ${BASE_DIR}/devstack.sh

echo "Install dein for management vim packages"
source ${BASE_DIR}/dein.sh
cp -i ${BASE_DIR}/vimrc_sample.txt ${HOME}/.vimrc

cat "source ${UTILS_DIR}/wf.sh" >> ${HOME}/.bashrc

echo "Done!"
