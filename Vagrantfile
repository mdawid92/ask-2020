# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"

 # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  
  config.vm.provider "virtualbox" do |vb|
    unless File.exist?("second.img")
      vb.customize ['createhd', '--filename', 'second.img', '--size', 5 * 1024]
    end
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', 'second.img']
    
    # raid devices
    unless File.exist?("sdc.img")
      vb.customize ['createhd', '--filename', 'sdc.img', '--size', 1024]
    end
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', 'sdc.img']
    
    unless File.exist?("sdd.img")
      vb.customize ['createhd', '--filename', 'sdd.img', '--size', 1024]
    end
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 3, '--device', 0, '--type', 'hdd', '--medium', 'sdd.img']
    
    unless File.exist?("sde.img")
    vb.customize ['createhd', '--filename', 'sde.img', '--size', 1024]
    end
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 4, '--device', 0, '--type', 'hdd', '--medium', 'sde.img']
    
    unless File.exist?("sdf.img")
      vb.customize ['createhd', '--filename', 'sdf.img', '--size', 1024]
    end
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 5, '--device', 0, '--type', 'hdd', '--medium', 'sdf.img']
  end
 
  config.vm.provision "shell", inline: <<-SHELL
    parted --script /dev/sdb "mklabel gpt"
    parted --script /dev/sdb "mkpart primary 1 100%"
    mkdir -m 0777 /data
    chown vagrant:vagrant /data
    mkfs.btrfs /dev/sdb1
    mount /dev/sdb1 /data

  SHELL
end
