#!/bin/bash

ETH_NAME=eth0
STATIC_IP=10.20.10.25
GATEWAY=10.20.10.1
DNS=10.20.10.1
PROXY=10.20.10.20

set -x

sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sed -i 's/GRUB_CMDLINE_LINUX=\"initrd=\/install\/gtk\/initrd.gz\"/GRUB_CMDLINE_LINUX=\"net.ifnames=0 biosdevname=0\"/g' /etc/default/grub
update-grub

cp -f ./sources.list /etc/apt/sources.list
echo "" > /etc/apt/apt.conf
apt update -y && apt upgrade -y

apt install gcc g++ git gdb make cmake bear clangd-16 htop sshpass tree zsh curl wget vim ssh zip unzip -y
apt install build-essential linux-headers-$(uname -r) python3-dev libncurses-dev ripgrep -y
apt install libperl-dev libssl-dev flex bison libelf-dev bc iptables conntrack netcat tcpdump linux-perf -y

chsh -s /bin/zsh

echo "" >> /etc/profile
echo "export http_proxy=http://${PROXY}:7890" >> /etc/profile
echo "export https_proxy=http://${PROXY}:7890" >> /etc/profile
echo "export no_proxy=localhost,127.0.0.1,${STATIC_IP}" >> /etc/profile

source /etc/profile

echo "" > /etc/network/interfaces
echo "source /etc/network/interfaces.d/*" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "auto lo" >> /etc/network/interfaces
echo "iface lo inet loopback" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "auto ${ETH_NAME}" >> /etc/network/interfaces
echo "iface ${ETH_NAME} inet static" >> /etc/network/interfaces
echo "address ${STATIC_IP}" >> /etc/network/interfaces
echo "gateway ${GATEWAY}" >> /etc/network/interfaces
echo "netmask 255.255.255.0" >> /etc/network/interfaces
echo "nameservers ${DNS}" >> /etc/network/interfaces

echo "nameserver ${DNS}" > /etc/resolv.conf

cp -f ./.zshrc /root/.zshrc
cp -rf ./.oh-my-zsh /root/.oh-my-zsh

sed -i "s/#no_proxy/export no_proxy=localhost,127.0.0.1,${STATIC_IP}/g" /root/.zshrc
sed -i "s/#http_proxy/export http_proxy=http:\/\/${PROXY}:7890/g" /root/.zshrc
sed -i "s/#https_proxy/export https_proxy=http:\/\/${PROXY}:7890/g" /root/.zshrc

cp -f ./.vimrc /root/.vimrc

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config
sed -i 's/#ClientAliveInterval 0/ClientAliveInterval 60/g' /etc/ssh/sshd_config
sed -i 's/#ClientAliveCountMax 3/ClientAliveCountMax 6000/g' /etc/ssh/sshd_config

mkdir /root/.ssh/
touch /root/.ssh/authorized_keys

git config --global user.name "shio"
git config --global user.email "wushaoxiong.shio@gmail.com"
