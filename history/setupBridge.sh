#!/bin/bash

set -e
set -x

# Set varibles
interfaceLastDigit=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'|cut -d "." -f4 )
let digit="$interfaceLastDigit-100"

BRIDGE_MAC='00:0a:bb:cc:dd:e'"$digit"
BRIDGE_IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}')
eth1_IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}')
LEFT_IP='172.22.101.'"$digit"'1/24'
RIGHT_IP='172.22.101.'"$digit"'2/24'


BRIDGE_NAME=mpbr0


mkdir -p /var/run/netns

# BRIDGE_MAC=00:0a:bb:cc:dd:ee

# BRIDGE_IP=172.22.101.201/24
# LEFT_IP=172.22.101.11/24
# RIGHT_IP=172.22.101.12/24
# eth1_IP=172.22.101.101/24

# BRIDGE_IP=172.22.101.202/24
# LEFT_IP=172.22.101.21/24
# RIGHT_IP=172.22.101.22/24
# eth1_IP=172.22.101.102/24

ip link add ${BRIDGE_NAME} type bridge
ip link set ${BRIDGE_NAME} address ${BRIDGE_MAC}
ip address add ${BRIDGE_IP} dev ${BRIDGE_NAME}
ip link set dev ${BRIDGE_NAME} up



docker run -itd --net=none --name left leodotcloud/golang:1.7
docker run -itd --net=none --name right leodotcloud/golang:1.7

ln -sv /proc/$(docker inspect -f '{{.State.Pid}}' left)/ns/net /var/run/netns/left
ln -sv /proc/$(docker inspect -f '{{.State.Pid}}' right)/ns/net /var/run/netns/right

ip link add h-left type veth peer name c-left

ip link set dev h-left master ${BRIDGE_NAME}
ip link set dev h-left up


ip link set c-left netns left
ip netns exec left ip link set dev c-left name eth0
ip netns exec left ip link set eth0 up
ip netns exec left ip addr add ${LEFT_IP} dev eth0


ip link add h-right type veth peer name c-right

ip link set dev h-right master ${BRIDGE_NAME}
ip link set dev h-right up


ip link set c-right netns right
ip netns exec right ip link set dev c-right name eth0
ip netns exec right ip link set eth0 up
ip netns exec right ip addr add ${RIGHT_IP} dev eth0

ip link set dev eth1 master ${BRIDGE_NAME}
ip addr del ${eth1_IP} dev eth1
ip addr del ${BRIDGE_IP} dev ${BRIDGE_NAME}
ip addr add ${eth1_IP} dev ${BRIDGE_NAME}
ip addr show





ip link add name veth_fbri type veth peer name dbri
ip link set dev veth_fbri master mpbr0
ip link set dev veth_fbri up
ip link set dev dbri master docker0
ip link set dev dbri up

ip addr add 172.22.101.4/24 dev veth_fbri

sudo apt-get install ebtables
ebtables -t nat -A POSTROUTING -p ARP -o eth1 --arp-ip-dst 172.17.0.0/16 -j DROP
ebtables -t nat -A POSTROUTING -p ARP -o eth1 --arp-ip-dst 169.254.169.250 -j DROP



#ebtables -t broute -A BROUTING -i veth_fbir -j DROP
#ebtables -t broute -A BROUTING -i veth_fbir -p ipv4 --ip-source 169.254.169.250 -j ACCEPT
#ebtables -t broute -A BROUTING -i veth_fbir -p arp --arp-opcode 2 --arp-ip-src 172.22.101.4 -j ACCEPT
#ebtables -t  nat -A POSTROUTING -p ARP -o eth1 --arp-op Request --arp-ip-dst 172.22.101.4 -j DROP
#ebtables -t  nat -A POSTROUTING -p ARP -o eth1 --arp-op Request --arp-ip-dst 169.254.169.250 -j DROP
