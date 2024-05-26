#!/bin/bash

ETH_NAME=ens32
STATIC_IP=10.20.10.50
GATEWAY=10.20.10.1
DNS=10.20.10.1
PROXY=10.20.10.20

sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub

cp -Rf ./sources.list /etc/apt/sources.list
echo "" > /etc/apt/apt.conf
apt update -y && apt upgrade -y
update-grub

apt install gcc g++ make git gdb htop sshpass bear tree zsh curl -y
apt install python3-dev libncurses-dev ripgrep universal-ctags -y
apt install lsb-release wget software-properties-common gnupg -y
apt install flex bison libelf-dev bc -y
apt install libperl-dev libssl-dev -y
apt install iptables conntrack netcat tcpdump linux-perf ftp vsftpd -y

chsh -s /bin/zsh

echo "" >> /etc/profile
echo "export http_proxy=http://${PROXY}:7890" >> /etc/profile
echo "export https_proxy=http://${PROXY}:7890" >> /etc/profile
echo "export no_proxy=localhost,127.0.0.1,${STATIC_IP}" >> /etc/profile
echo "export PATH=/usr/local/cmake/bin:/usr/lib/llvm-15/bin:\$PATH" >> /etc/profile

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
echo "dns-nameservers ${DNS}" >> /etc/network/interfaces

echo "nameserver ${DNS}" > /etc/resolv.conf

cp -Rf ./.zshrc /root/.zshrc
cp -Rf ./.oh-my-zsh /root/.oh-my-zsh

sed -i "s/#no_proxy/export no_proxy=localhost,127.0.0.1,${STATIC_IP}/g" /root/.zshrc
sed -i "s/#http_proxy/export http_proxy=http:\/\/${PROXY}:7890/g" /root/.zshrc
sed -i "s/#https_proxy/export https_proxy=http:\/\/${PROXY}:7890/g" /root/.zshrc

cp -Rf ./.vimrc /root/.vimrc

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config
sed -i 's/#ClientAliveInterval 0/ClientAliveInterval 60/g' /etc/ssh/sshd_config
sed -i 's/#ClientAliveCountMax 3/ClientAliveCountMax 6000/g' /etc/ssh/sshd_config

mkdir /root/.ssh/
touch /root/.ssh/authorized_keys

git config --global user.name "shio"
git config --global user.email "wushaoxiong.shio@gmail.com"

./llvm.sh 15
