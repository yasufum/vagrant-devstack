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

Then, setup your ``machines.yml`` in which parameters of VMs you will deploy
are defined from ``samples/machines.yml`` before launching VMs.

```sh
$ cp samples/machines.yml .
$ YOUR_FAVORITE_EDITOR machines.yml
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

Install ``vagrant-proxyconf`` plugin if you are in proxy environment.

```sh
$ vagrant plugin install vagrant-proxyconf
```

Now, you are ready to run Vagrantfile.

### Run vagrant with Vagrantfile

Vagrantfile defines params for the VM (cpu, memory, etc.) and
steps for installation.

You should edit parameters in `machines.yml` to be appropriate for your
environment.

```yaml
machines:

  - hostname: controller
    provider: virtualbox
    box: ubuntu/focal64
    nof_cpus: 4
    mem_size: 8
    disk_size: 50
    private_ips:
      - 192.168.33.11
    public_ips:
    fwd_port_list:
      - guest: 80
        host: 10080
```

By running `vagrant up`, basic packages, such as python3 or git,
are install and stack user is created on the VM.

### Build OpenStack Environment

After VM is launched, login and install DevStack.

You can setup and devstack and tools for building OpenStack environment
at once by running `all.sh` installer scripts.
If you do not install all of tools, you can run each of scripts in
`/vagrant/installer/`.

```sh
$ vagrant ssh
# Change to stack user
$ sudo su - stack
$ /vagrant/installer/all.sh # run all of scripts
```

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
