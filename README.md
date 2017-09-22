# vagrant-devstack

## What is this

Vagrantfile for install devstack on
[VirtualBox](https://www.virtualbox.org/).
It is planned to support libvirt or other hypervisors.

Here is the most simple usecase.

```sh
$ vagrant up
# Launching a VM ...
$ vagrant ssh
$ sudo su - stack
$ /vagrant/installer/all.sh
$ cd devstack
$ cp samples/local.conf .
# Edit local.conf
$ ./stack.sh
```

Japanese README_ja.md is [here](doc/README_ja.md).

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
and `vagrant-proxyconf` plugin if you are in proxy environment.

```sh
$ vagrant plugin install vagrant-proxyconf
```

This tool downloads and uses xenial64 of official box from Ubuntu.
If you use other box, you need to edit Vagrantfile.

Now, you are ready to run Vagrantfile.

### Run Vagrantfile

Vagrantfile defines params for the VM (cpu, memory, etc.) and
steps for installation.

You should edit params to be appropriate for your environment.
On the other hand, you should not edit installation in provision
seciton at the last part.

```ruby
# Vagrantfile

# VM params
NOF_CPU = 2
MEMSIZE = 6  # MB

# Define hypervisor.
# Currently, "virtualbox" or "libvirt" is supported as default.
hv_type = "virtualbox"
```

By running Vagrantfile, packages are installed and stack user is
created on the VM.

```sh
vagrant up
```

### Get DevStack

After VM is launched, login and install DevStack.

You can setup and get for devstack and other tools
by running `all.sh` support scripts.

```sh
$ vagrant ssh
# Change to stack user
$ sudo su - stack
$ /vagrant/installer/all.sh # run all of support scripts
```

There are three categories of support scripts
in `/vagrant/` on the VM.
If you do not install all of tools, you run each of scripts in
`/vagrant/installer/`.

1. helper: add/delete stack user to clear your installation.
1. install: change configurations for installation and do.
  * all.sh: install all of packages (no need if you run each installon
    by yourself).
  * devstack.sh: get and setup devstack (NOT installed yet).
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

### Install DevStack

Finally, create your local.conf and run `stack.sh` for installation.

```sh
$ cd devstack
$ cp samples/local.conf .
$ vim local.conf  # edit it with your favorite editor
$ ./stack.sh
```

Congulaturations! or you might have an error while running `stack.sh`
because of a bug :)
