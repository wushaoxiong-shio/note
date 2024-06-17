# NOTE

```shell
# exsi 列出所有硬盘信息
esxcli storage core device list
# exsi 查看指定硬盘的smart运行健康状态，以SN570为例
esxcli storage core device smart get -d t10.NVMe____WD_Blue_SN570_2TB_SSD___________________F3A87A4E8B441B00

####

alias mkernel='make -j32 && make modules_install && make install && update-grub'

apt install vsftpd ftp zip unzip tcpdump iptables conntrack netcat -y

modprobe -v iptable_nat

iptables -t nat -A POSTROUTING -s 10.20.10.0/24 -o ens33 -j MASQUERADE

echo 1 > /proc/sys/net/ipv4/ip_forward

vim /etc/sysctl.conf
net.ipv4.ip_forward=1


vim /etc/default/grub
GRUB_DEFAULT="Advanced options for Debian GNU/Linux>Debian GNU/Linux, with Linux 5.10.0-26-amd64"

vim /boot/grub/grub.cfg

#define NIPQUAD(addr) \
((unsigned char *)&addr)[0], \
((unsigned char *)&addr)[1], \
((unsigned char *)&addr)[2], \
((unsigned char *)&addr)[3]

```

