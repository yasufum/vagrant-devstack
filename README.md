# vagrant-devstack

## What is this

Vagrantfile for install devstack on
[VirtualBox](https://www.virtualbox.org/).

Here is the most simple usecase.

```sh
$ vagrant up
# Launching a VM ...
$ vagrant ssh
$ /vagrant/install/all.sh
$ cd devstack
$ cp samples/local.conf .
# Edit local.conf
$ ./stack.sh
```

Japanese README_ja.md is [here](docs/README_ja.md).

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
and download vagrant box.
As defiend in Vagrantfile, this tool expects to use xenial64 of
official box from Ubuntu.
Run `vagrant box` command to get the box.

```sh
$ vagrant box add ubuntu/xenial64
# Show all of boxes installed
$ vagrant box list
```

Now, you are ready to run Vagrantfile.

### Run Vagrantfile

Vagrantfile defines params for the VM (cpu, memory, etc.) and
steps for installation.

You should edit params to be appropriate for your environment.
On the other hand, you should not edit installation in provision
seciton at the last part.

By running Vagrantfile, packages are installed and stack user is
created no the VM.

```sh
vagrant up
```

### Get DevStack

After VM is launched, login and install DevStack.

You can setup and get for devstack by using support scripts.

```sh
$ vagrant ssh
$ /vagrant/install/all.sh # run all of support scripts
```

There are three categories of support scripts
in `/vagrant/`.
You can also use any of script without using `all.sh`.

1. helper: add/delete stack user to clear your installation.
1. install: change configurations for installation and do.
  * all.sh: install all of packages (no need if you run each installon
    by yourself).
  * devstack.sh: get and setup devstack (DO NOT install yet).
  * dein.sh: setup and install dein (vim package manager).
1. util: add utility function for your shell by including in `.bashrc`.
  * wf.sh: word find function for search target word from files in current.
    child dirs 

```
/vagrant
├── helper
│   ├── add_stack_user.sh
│   └── del_user.sh
├── installer
│   ├── all.sh
│   ├── dein.sh
│   ├── devstack.sh
│   └── vimrc_sample.txt
└── util
    └── wf.sh
```

### Install devstack

Finally, create your local.conf and run `stack.sh` for installation.

```sh
$ cd devstack
$ cp samples/local.conf .
$ vim local.conf  # edit it with your favorite editor
$ ./stack.sh
```

Congulaturations! or you might have an error while running `stack.sh`
because of a bug :)
