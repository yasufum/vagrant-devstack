require "yaml"

class Machines < Array

  class Machine
    attr_reader :name, :provider, :box, :nof_cpus, :mem_size, :disk_size,
      :private_ips, :public_ips, :fwd_port_list

    def initialize(
      name="controller", provider="virtualbox", box="ubuntu/focal64",
      nof_cpus=2, mem_size=4, disk_size=10,
      private_ips=["192.168.33.11"], public_ips=nil, fwd_port_list=nil)
      @name = name
      @provider = provider
      @box = box
      @nof_cpus = nof_cpus
      @mem_size = mem_size
      @disk_size = disk_size
      @private_ips = private_ips
      @public_ips = public_ips
      @fwd_port_list = fwd_port_list
    end
  end

  def initialize(yaml_file)
    y = YAML.load(yaml_file)
    y["machines"].each_with_index do |m, idx|
      self[idx] = Machine.new(
        m["name"], m["provider"], m["box"],
        m["nof_cpus"], m["mem_size"], m["disk_size"],
        m["private_ips"], m["public_ips"], m["fwd_port_list"])
    end
  end

end
