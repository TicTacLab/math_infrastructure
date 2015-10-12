# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.provider "virtualbox" do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.define("vmalt01") do |node|
    node.vm.network "private_network", ip: "192.168.167.144"
    node.vm.hostname = "vmalt01.local"
    node.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define("vmalt02") do |node|
    node.vm.network "private_network", ip: "192.168.167.145"
    node.vm.hostname = "vmalt02.local"
    node.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define("vmalt03") do |node|
    node.vm.network "private_network", ip: "192.168.167.146"
    node.vm.hostname = "vmalt03.local"
    node.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end


  config.vm.define("nginx") do |node|
    node.vm.network "private_network", ip: "192.168.167.140"
    node.vm.hostname = "nginx.local"
    node.vm.provider "virtualbox" do |v|
      v.memory = 400
      v.cpus = 2
    end
  end
 
  config.vm.provision "shell" do |s|
    s.inline = <<-SHELL
      useradd -d /home/malt_deploy -m -s /bin/bash -p "$(openssl passwd -1 WynorOpt8)" -G sudo malt_deploy
      sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
      echo "%sudo        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
    SHELL
  end
end
