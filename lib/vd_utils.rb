# Util method in vagrant-devstack
module VdUtils

  def ssh_pub_key(config)
    if config["global"] != nil
      if config["global"]["ssh_pub_key"]
        key_path = File.expand_path(
          config["global"]["ssh_pub_key"].gsub("$HOME", "~"))
      end
    end
    
    key_path = "~/.ssh/id_rsa.pub" if key_path == nil
    
    begin
      ssh_pub_key = open(key_path).read.chomp
    rescue => e
      puts e
    end

    return ssh_pub_key
  end

  module_function :ssh_pub_key
end
