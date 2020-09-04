#!/bin/sh

SCRIPT_DIR=`dirname $0`

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp -i ${SCRIPT_DIR}/vimrc ${HOME}/.vimrc

# Ctags is required for plugin 'vim-scripts/taglist.vim'
sudo apt install exuberant-ctags -y
