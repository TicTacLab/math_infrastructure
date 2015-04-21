# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "chef/centos-7.0"

  config.vm.provider "virtualbox" do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.define("vmalt01") do |node|
    node.vm.network "private_network", ip: "192.168.167.144"
    node.vm.hostname = "dc01m01.favorit"
    node.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define("vmalt02") do |node|
    node.vm.network "private_network", ip: "192.168.167.145"
    node.vm.hostname = "dc01m02.favorit"
    node.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define("vmalt03") do |node|
    node.vm.network "private_network", ip: "192.168.167.146"
    node.vm.hostname = "dc01m03.favorit"
    node.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end


  config.vm.define("nginx") do |node|
    node.vm.network "private_network", ip: "192.168.167.140"
    node.vm.hostname = "nginx0"
    node.vm.provider "virtualbox" do |v|
      v.memory = 400
      v.cpus = 2
    end
  end
 
  config.vm.define("zabbix") do |node|
    node.vm.network "private_network", ip: "192.168.167.141"
    node.vm.hostname = "zabbix"
    node.vm.provider "virtualbox" do |v|
      v.memory = 400
      v.cpus = 2
    end
  end


  config.vm.provision "shell" do |s|
    s.inline = <<-SHELL
      adduser -d /home/malt_deploy -m -s /bin/bash -p "$(openssl passwd -1 WynorOpt8)" -G wheel malt_deploy
      sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
      echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
      echo "SELINUX=disabled" > /etc/sysconfig/selinux
      echo "SELINUXTYPE=targeted" >> /etc/sysconfig/selinux
      reboot
    SHELL
  end
end
