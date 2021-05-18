# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

require "yaml"
load "lib/machine.rb"
load "lib/vd_utils.rb"

config = YAML.load(open("machines.yml"))

ssh_pub_key = VdUtils.ssh_pub_key(config)
machines = Machines.new(config["machines"])

# Check if you have already downloaded target box.
box_list = []
`vagrant box list`.each_line {|l|
  box_list << l.split(" ")[0]
}

# If you don't have the box, download it.
machines.each do |m|
  if not (box_list.include? m.box)
    puts "There is no box '#{m.box}' for '#{m.provider}'"
    puts "Run 'vagrant box add #{m.box}' first"
  end
end

Vagrant.configure("2") do |config|
  machines.each do |machine|
    config.vm.define machine.hostname do |server|
      server.vm.box = machine.box
      server.vm.hostname = machine.hostname

      # server.vm.box_check_update = false

      machine.private_ips.each do |ipaddr|
        server.vm.network "private_network", ip: ipaddr
      end

      if machine.public_ips != nil
        machine.public_ips.each do |ipaddr|
          server.vm.network "public_network", ip: ipaddr
        end
      end

      machine.fwd_port_list.each do |fp|
        ["tcp", "udp"].each do |prot|
          server.vm.network "forwarded_port",
              guest: fp["guest"], host: fp["host"],
              auto_correct: true, protocol: prot
        end
      end

      if Vagrant.has_plugin?("vagrant-proxyconf")
        server.proxy.http = ENV["http_proxy"]
        server.proxy.https = ENV["https_proxy"]
        if ENV["no_proxy"] != ""
          server.proxy.no_proxy = ENV["no_proxy"] +
              "," + machine.private_ips.join(",")
        end
      end

      if Vagrant.has_plugin?("vagrant-disksize")
        server.disksize.size = "#{machine.disk_size}GB"
      end

      # TODO(yasufum) This configuration reported in [1] is required to avoid
      # timeout for ssh login to focal64 because of setting up public key in the
      # VM. This issue is only happened on focal, and not for bionic and xenial.
      # Remove this config after the problem is fixed in the focal image.
      # [1] https://bugs.launchpad.net/cloud-images/+bug/1829625
      if machine.box == "ubuntu/focal64"
        server.vm.provider 'virtualbox' do |v|
          v.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
          v.customize ["modifyvm", :id, "--uartmode1", "file", "./ttyS0.log"]
        end
      end

      if machine.ssh_forward_x11 == true
        server.ssh.forward_x11 = true
      end

      server.vm.provider machine.provider do |vb|
      #   # Display the VirtualBox GUI when booting the machine
      #   vb.gui = true
      #
      #   # Customize the amount of memory on the VM:
        #vb.customize ["modifyhd", "disk id", "--resize", "size in megabytes"]
        vb.cpus = "#{machine.nof_cpus}"
        vb.memory = "#{machine.mem_size * 1024}"
      end

      server.vm.provision "shell", inline: <<-SHELL
        useradd -s /bin/bash -d /opt/stack -m stack
        echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
        echo "export VAGRANT_PRIVATE_IP0=#{machine.private_ips[0]}" >> /opt/stack/.bashrc
        mkdir -p /opt/stack/.ssh
        echo "#{ssh_pub_key}" >> /opt/stack/.ssh/authorized_keys
      SHELL

    end
  end
end
