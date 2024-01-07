# Debian 11

~~~shell

apt install flex bison libelf-dev libssl-dev bc -y

make distclean or make mrproper

cp /boot/config-$(uname -r) .config or make menuconfig

vim .config
# CONFIG_DEBUG_INFO_BTF 调试、性能分析工具开关，编译需要的依赖库在 Debian11上版本太低，不好安装，用不到 BTF 直接关闭即可
CONFIG_DEBUG_INFO_BTF=n
# 字段值置空
CONFIG_SYSTEM_TRUSTED_KEYS=""

# 打成 deb 包形式，可以给其他设备安装
make -j32 deb-pkg
dpkg -i ../*.deb

# 直接源码本地安装
make -j32
make modules_install
make install

# 更新 grub
update-grub

# 生成索引
bear -- make -C /root/code/linux-5.10.26 M=`pwd` -j32

# 
alias mkernel='make -j32 && make modules_install && make install && update-grub'


~~~

