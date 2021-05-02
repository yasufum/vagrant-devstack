#!/bin/sh

# Avoid error because stack.sh tries to clone with git protocol
# You can use GIT_BASE=https://openstack.org instead.
git config --global url."https://".insteadOf git://

git clone https://opendev.org/openstack/tacker.git

# Install generate-subunit
# It is required packages from stack.sh
sed "s/^HOST_IP=127.0.0.1/HOST_IP=${HOSTIP}/g" \
    ${HOME}/tacker/devstack/local.conf.example \
    > ${HOME}/devstack/local.conf
