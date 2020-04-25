#!/bin/sh

# Avoid error because stack.sh tries to clone with git protocol
# You can use GIT_BASE=https://openstack.org instead.
git config --global url."https://".insteadOf git://

git clone https://opendev.org/openstack/devstack.git

# Install generate-subunit
# It is required packages from stack.sh
pip3 install -U os-testr
pip3 install tox
