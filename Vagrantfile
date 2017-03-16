# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
$install_docker = <<INSTALL_DOCKER
echo Installing docker
curl -sSL https://releases.rancher.com/install-docker/1.12.sh | sh
sudo usermod -aG docker vagrant
INSTALL_DOCKER


Vagrant.configure(2) do |config|

  config.vm.provision "shell", inline: $install_docker
  #config.vm.provision "shell", path:"setupBridge.sh"

  config.vm.define "cattleh1" do |cattleh1|
    cattleh1.vm.hostname = 'cattleh1'
    cattleh1.vm.box= "ubuntu/trusty64"
    cattleh1.vm.box_url = "ubuntu/trusty64"

    cattleh1.vm.network :private_network, ip: "172.22.101.101",
      nic_type: "82545EM"

    cattleh1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "cattleh1"]
      v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end
  end

  config.vm.define "cattleh2" do |cattleh2|
    cattleh2.vm.hostname = 'cattleh2'
    cattleh2.vm.box= "ubuntu/trusty64"
    cattleh2.vm.box_url = "ubuntu/trusty64"

    cattleh2.vm.network :private_network, ip: "172.22.101.102",
      nic_type: "82545EM"

    cattleh2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "cattleh2"]
      v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end
  end

   config.vm.define "cattleh3" do |cattleh3|
     cattleh3.vm.hostname = 'cattleh3'
     cattleh3.vm.box= "centos/7"
     cattleh3.vm.box_url = "centos/7"

     cattleh3.vm.network :private_network, ip: "172.22.101.103",
       nic_type: "82545EM"

     cattleh3.vm.provider :virtualbox do |v|
       v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
       v.customize ["modifyvm", :id, "--memory", 2048]
       v.customize ["modifyvm", :id, "--name", "cattleh3"]
       v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
     end
   end

end
