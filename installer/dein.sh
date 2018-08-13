#!/bin/sh

DEIN_DIR=$HOME/dein
SCRIPT_DIR=`dirname $0`

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ${HOME}/installer.sh
sh ${HOME}/installer.sh ${DEIN_DIR}
rm ${HOME}/installer.sh

# setup nvim config
mkdir -p ${HOME}/.config/nvim
cp -i ${SCRIPT_DIR}/conf_nvim.txt ${HOME}/.config/nvim/init.vim
