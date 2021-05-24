# Util method in vagrant-devstack

require "fileutils"

module VdUtils

  # Get the contents of SSH public key to upload it to VMs.
  def ssh_pub_key(config)
    default_key_path = "~/.ssh/id_rsa.pub"

    if config["global"] != nil
      if config["global"]["ssh_pub_key"]
        key_path = File.expand_path(
          config["global"]["ssh_pub_key"].gsub("$HOME", "~"))
      end
    end
    
    key_path = default_key_path if key_path == nil
    
    begin
      ssh_pub_key = open(key_path).read.chomp
    rescue => e
      puts e
    end

    return ssh_pub_key
  end


  def setup_git_config()
    src = "~/.gitconfig"
    dst = "roles/controller/templates/gitconfig.j2"

    gitconfig = File.expand_path src
    if File.exists? gitconfig
      FileUtils.copy(gitconfig, dst)
    end
  end

  module_function :ssh_pub_key, :setup_git_config
end
