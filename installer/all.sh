#!/bin/bash

BASE_DIR=/vagrant/installer

echo "Install devstack and related packages"
source ${BASE_DIR}/devstack.sh

echo "Install dein for management vim packages"
source ${BASE_DIR}/dein.sh
cp -i ${BASE_DIR}/vimrc_sample.txt $HOME/.vimrc

echo "Done!"
