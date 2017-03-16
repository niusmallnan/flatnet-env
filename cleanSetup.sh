#!/bin/bash

set -e
set -x

BRIDGE_NAME=mpbr0
eth1_IP=172.22.101.101/24

veth_in_use=()
docker_in_user=()

function veth_interface_for_container() {
    local pid=$(docker inspect -f '{{.State.Pid}}' "${1}")
    mkdir -p /var/run/netns
    ln -sf /proc/$pid/ns/net "/var/run/netns/${1}"
    local index=$(ip netns exec "${1}" ip link show eth0 | head -n1 | sed s/:.*//)
    let index=index+1
    ip link show | grep "^${index}:" | sed "s/${index}: \(.*\):.*/\1/"
    rm -f "/var/run/netns/${1}"
}

for i in $(docker ps | grep Up | awk '{print $1}')
do
    if [ "$(veth_interface_for_container $i)" != "docker0" ]
    then
        veth_in_use+=($(veth_interface_for_container $i))
        docker_in_user+=($i)
    fi
done

for i in "${veth_in_use[@]}"
do
    ip link set $i down
    ip link delete $i
done

for i in "${docker_in_user[@]}"
do
     docker stop $i
     docker rm $i
done


ifconfig ${BRIDGE_NAME} down
ip link delete ${BRIDGE_NAME} type bridge

ifconfig eth1 ${eth1_IP}

for i in $(ip netns list)
do
    ip netns del $i
done
