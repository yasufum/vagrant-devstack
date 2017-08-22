#!/bin/sh

DEIN_DIR=$HOME/dein

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $HOME/installer.sh
sh $HOME/installer.sh ${DEIN_DIR}
rm $HOME/installer.sh
