# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

require "yaml"
load "lib/machine.rb"

y = YAML.load(open("machines.yml"))
m = y["machines"][0]
machine = Machine.new(m["provider"], m["box"], m["nof_cpus"], m["mem_size"], m["disk_size"],
    m["private_ips"], m["public_ips"], m["fwd_port_list"])

# Check if you have already downloaded target box.
box_list = []
`vagrant box list`.each_line {|l|
  box_list << l.split(" ")[0]
}

# If you don't have the box, download it.
if not (box_list.include? machine.box)
  puts "There is no box '#{machine.box}' for '#{machine.provider}'"
  puts "Run 'vagrant box add #{machine.box}' first"
end

Vagrant.configure("2") do |config|
  config.vm.box = machine.box

  # config.vm.box_check_update = false

  machine.pri_ips.each do |ipaddr|
    config.vm.network "private_network", ip: ipaddr
  end

  if machine.pub_ips != nil
    machine.pub_ips.each do |ipaddr|
      config.vm.network "public_network", ip: ipaddr
    end
  end

  machine.fwd_port_list.each do |fp|
    ["tcp", "udp"].each do |prot|
      config.vm.network "forwarded_port", guest: fp["guest"], host: fp["host"], auto_correct: true, protocol: prot
    end
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http = ENV["http_proxy"]
    config.proxy.https = ENV["https_proxy"]
    if ENV["no_proxy"] != ""
      config.proxy.no_proxy = ENV["no_proxy"] + "," + machine.pri_ips.join(",")
    end
  end

  if Vagrant.has_plugin?("vagrant-disksize")
    config.disksize.size = "#{machine.disk_size}GB"
  end

  # TODO(yasufum) This configuration reported in [1] is required to avoid
  # timeout for ssh login to focal64 because of setting up public key in the
  # VM. This issue is only happened on focal, and not for bionic and xenial.
  # Remove this config after the problem is fixed in the focal image.
  # [1] https://bugs.launchpad.net/cloud-images/+bug/1829625
  if machine.box == "ubuntu/focal64"
    config.vm.provider 'virtualbox' do |v|
      v.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
      v.customize ["modifyvm", :id, "--uartmode1", "file", "./ttyS0.log"]
    end
  end

  config.vm.provider machine.provider do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    #vb.customize ["modifyhd", "disk id", "--resize", "size in megabytes"]
    vb.cpus = "#{machine.nof_cpus}"
    vb.memory = "#{machine.mem_size * 1024}"
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-upgrade -y
    apt-get install -y python3 python3-dev
    apt-get install -y python3-pip bridge-utils
    apt-get install -y git git-review
    useradd -s /bin/bash -d /opt/stack -m stack
    echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
  SHELL
end
