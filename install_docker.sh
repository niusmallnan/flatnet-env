#!/bin/bash

sudo cp /vagrant/apt.sources.list /etc/apt/sources.list
echo Installing docker
curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sed 's/apt-get install -y -q docker-engine/apt-get install -y -q docker-engine=1.12.6-0~ubuntu-trusty/g' | sh -
sudo usermod -aG docker vagrant
echo "DOCKER_OPTS=\"\$DOCKER_OPTS --registry-mirror=https://s06nkgus.mirror.aliyuncs.com\"" | sudo tee -a /etc/default/docker
sudo service docker restart

