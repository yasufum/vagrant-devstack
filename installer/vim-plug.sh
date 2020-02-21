#!/bin/sh

SCRIPT_DIR=`dirname $0`

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp -i ${SCRIPT_DIR}/vimrc ${HOME}/.vimrc
