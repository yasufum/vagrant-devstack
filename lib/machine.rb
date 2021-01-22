class Machine
  attr_reader :provider, :box, :nof_cpus, :mem_size, :disk_size,
    :pri_ips, :pub_ips, :fwd_port_list

  def initialize(provider="virtualbox", box="ubuntu/focal64",
                 nof_cpus=2, mem_size=4, disk_size=10,
                 pri_ips=["192.168.33.11"], pub_ips=nil, fwd_port_list=nil)
    @provider = provider
    @box = box
    @nof_cpus = nof_cpus
    @mem_size = mem_size
    @disk_size = disk_size
    @pri_ips = pri_ips
    @pub_ips = pub_ips
    @fwd_port_list = fwd_port_list
  end

end
