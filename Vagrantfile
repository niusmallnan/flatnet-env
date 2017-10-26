# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
#
Vagrant.configure(2) do |config|

  config.vm.provision "shell", path:"install_docker.sh"

  config.vm.define "cattleh1" do |cattleh1|
    cattleh1.vm.hostname = 'cattleh1'
    cattleh1.vm.box= "ubuntu/trusty64"
    cattleh1.vm.box_url = "ubuntu/trusty64"

    cattleh1.vm.network :private_network, ip: "172.22.101.2",
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

    cattleh2.vm.network :private_network, ip: "172.22.101.3",
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

    cattleh3.vm.network :private_network, ip: "172.22.101.4",
      nic_type: "82545EM"

    cattleh3.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "cattleh3"]
      v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end
  end

  config.vm.define "cattleh4" do |cattleh4|
    cattleh4.vm.hostname = 'cattleh4'
    cattleh4.vm.box= "ubuntu/trusty64"
    cattleh4.vm.box_url = "ubuntu/trusty64"

    cattleh4.vm.network :private_network, ip: "172.22.101.5",
      nic_type: "82545EM"

    cattleh4.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "cattleh4"]
      v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end
  end

  config.vm.define "cattleh5" do |cattleh5|
    cattleh5.vm.hostname = 'cattleh5'
    cattleh5.vm.box= "MatthewHartstonge/RancherOS"
    cattleh5.vm.box_url = "MatthewHartstonge/RancherOS"

    cattleh5.vm.network :private_network, ip: "172.22.101.6",
      nic_type: "82545EM"

    cattleh5.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "cattleh5"]
      v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end
  end

end
