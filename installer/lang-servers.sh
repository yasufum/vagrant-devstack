#!/bin/sh

bash_ls() {
    sudo apt install npm -y
    sudo npm i -g bash-language-server
}

py_ls() {
    pip3 install python-language-server
}

bash_ls
py_ls
