# Debian 11

~~~shell

apt install flex bison libelf-dev libssl-dev bc -y

make distclean
make mrproper

cp /boot/config-$(uname -r) .config

make menuconfig

vim .config
CONFIG_DEBUG_INFO_BTF=n
CONFIG_SYSTEM_TRUSTED_KEYS=""

make -j32 deb-pkg
dpkg -i ../*.deb

make -j32
make modules -j32
make modules_install
make install

update-grub



# 
dpkg --get-selections | grep linux

apt --purge autoremove linux-image-5.10.0-22-amd64 -y













~~~

