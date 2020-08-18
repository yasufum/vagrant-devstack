# vagrant-devstack


## What is this

Vagrantfile and helper scripts for install devstack on a VM created by
[VirtualBox](https://www.virtualbox.org/).


## Getting Started

Before launching your VM, you shold install plugin ``vagrant-disksize``
for expanding size of volume of VM. It is because the default size of
boxes provided from ubuntu, 10GB or so, is not enough for deploying
devstack environment.

```sh
$ vagrant plugin install vagrant-disksize
```

Then, setup ``Vagrantfile`` and Launch a VM with ``vagrant``.
This tool provides a template ``Vagrantfile.orig``, so you can use it
as it is if you launch the VM with minimum required configuration, or
customize it for your usage.

```sh
$ cp Vagrantfile.orig Vagrantfile
$ vagrant up
```

You should export your git environment on host to the VM for developing
your features on the VM and upload it with `git review`.
`helper/git_setup_gen.sh` is used for generating a script
`helper/git_setup.sh` to upload your minimum git environment on the VM.

```sh
# Generate helper/git_setup.sh
$ sh helper/git_setup_gen.sh
```

Login and Change to stack user next.

```sh
$ vagrant ssh
$ sudo su - stack
```

Run all of installation at once.

```sh
$ /vagrant/installer/all.sh
```

If you created `helper/git_setup.sh`, run this script
to import the git environment.

```sh
$ /vagrant/helper/git_setup.sh
```

Setup devstack.

```sh
$ cd devstack
$ cp samples/local.conf .
# Edit local.conf and run stack.sh
$ ./stack.sh
```


## How to use

This tool is automatically do installation before `Create local.conf`
described in
[DevStack Quick Start](https://docs.openstack.org/devstack/latest/).
You need to create your local.conf and run `stack.sh` on your own.

### Install VirtualBox and Vagrant

First of all, you need to download VirtualBox from
[here](https://www.virtualbox.org/) and install.

You also need to install
[vagrant](https://www.vagrantup.com/)
and its plugins.
``vagrant-disksize`` is for expanding a size of volume of VM.
It is because the default size is not enough for deploying devstack
environment.

```sh
$ vagrant plugin install vagrant-disksize
```

Install `vagrant-proxyconf` plugin if you are in proxy environment.

```sh
$ vagrant plugin install vagrant-proxyconf
```

Now, you are ready to run Vagrantfile.

### Run Vagrantfile

Vagrantfile defines params for the VM (cpu, memory, etc.) and
steps for installation.

You should edit params to be appropriate for your environment.
On the other hand, you should not edit installation in provision
seciton at the last part.
This tool downloads and uses xenial64 of official box from Ubuntu.

```ruby
# Vagrantfile

# VM params. 2 CPUs and 8GB memory are the minimum requirements.
NOF_CPU = 8
MEMSIZE = 18  # GB
DISK_SIZE = 50  # GB
...
# Define hypervisor.
# Currently, "virtualbox" or "libvirt" is supported as default.
my_provider = "virtualbox"
dist_ver = "18.04"
```

By running `vagrant up`, following packages are install and
stack user is created on the VM.

```sh
apt-get install -y python python-pip bridge-utils
apt-get install -y git git-review
```

### Get DevStack

After VM is launched, login and install DevStack.

You can setup and get for devstack and other tools
by running `all.sh` support scripts.
If you do not install all of tools, you run each of scripts in
`/vagrant/installer/`.

```sh
$ vagrant ssh
# Change to stack user
$ sudo su - stack
$ /vagrant/installer/all.sh # run all of support scripts
```

### Build OpenStack Environment

Finally, create your local.conf and run `stack.sh` under cloned `devstack`
directory.

```sh
$ cd devstack
$ cp samples/local.conf .
$ vim local.conf  # edit it with your favorite editor
$ ./stack.sh
```

Congulaturations! or you might have an error while running `stack.sh`
because of a bug :)
