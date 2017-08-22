#!/bin/sh

git clone https://git.openstack.org/openstack-dev/devstack

# Avoid error because stack.sh tries to clone with git protocol
# You can use GIT_BASE=https://openstack.org instead.
git config --global url."https://".insteadOf git://

# Install generate-subunit
# It is required packages from stack.sh
pip install -U os-testr
