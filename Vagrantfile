# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

# VM params
NOF_CPU = 2
MEMSIZE = 6  # GB
HOST_IP = "192.168.33.11"

# Define hypervisor.
# Currently, "virtualbox" or "libvirt" is supported as default.
hv_type = "libvirt"

# Vagrant boxes
# [NOTE] You can use any of box by changing 'box' attribute or
#        other entries of hypervisor.
#        Please refer to https://app.vagrantup.com/boxes/search
#        for available box list.
#        'provider' attribute must be correspond to 'hv_type'.
hv_types = {
  virtualbox: {provider: "virtualbox", box: "ubuntu/xenial64"},
  libvirt: {provider: "libvirt", box: "yk0/ubuntu-xenial"}
}

my_box = hv_types[hv_type.to_sym][:box]
my_provider = hv_types[hv_type.to_sym][:provider]

# Check if you have already downloaded target box.
box_list = []
`vagrant box list`.each_line {|l|
  box_list << l.split(" ")[0]
}

# If you don't have the box, download it.
if not (box_list.include? my_box)
  puts "There is no box '#{my_box}' for '#{hv_type}'"
  puts "Run 'vagrant box add #{my_box}' first"
end

Vagrant.configure("2") do |config|
  #config.ssh.insert_key = true
  #config.ssh.username = "ubuntu"
  #config.ssh.password = "48a16ff5a87dbd49b28864f6"
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  #config.vm.box = "ubuntu/trusty64"
  config.vm.box = my_box

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  host_ip = HOST_IP
  config.vm.network "private_network", ip: host_ip

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http = ENV["http_proxy"]
    config.proxy.https = ENV["https_proxy"]
    if ENV["no_proxy"] != ""
      config.proxy.no_proxy = ENV["no_proxy"] + "," + host_ip
    end
  end

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:


  config.vm.provider my_provider do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    #vb.customize ["modifyhd", "disk id", "--resize", "size in megabytes"]
    vb.cpus = "#{NOF_CPU}"
    vb.memory = "#{MEMSIZE * 1024}"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y python python-pip bridge-utils
    apt-get install -y git git-review
    useradd -s /bin/bash -d /opt/stack -m stack
    echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
  SHELL
end
