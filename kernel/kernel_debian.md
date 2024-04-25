# Debian 11

~~~shell

apt install flex bison libelf-dev libssl-dev bc -y

make distclean or make mrproper

cp /boot/config-$(uname -r) .config or make menuconfig
# default
make x86_64_defconfig

cp /boot/config-$(uname -r) .config

make menuconfig

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



## 使用 tmpfs 虚拟文件系统加快编译

```shell
# 创建挂载点： 首先，需要创建一个目录作为挂载点，用来挂载 tmpfs 文件系统
mkdir /mnt/tmpfs
# 挂载 tmpfs 文件系统： 使用 mount 命令来挂载 tmpfs 文件系统
mount -t tmpfs -o size=512M tmpfs /mnt/tmpfs

-t tmpfs：指定文件系统类型为 tmpfs。
-o size=512M：设置 tmpfs 的大小为 512MB，根据实际需要调整大小。
tmpfs：文件系统类型即 df -h 显示的文件系统名。
/mnt/tmpfs：挂载点路径

# 查看挂载信息： 可以使用 mount 命令查看已挂载的文件系统信息
mount | grep tmpfs

# 卸载 tmpfs 文件系统： 当不再需要使用时，可以使用 umount 命令卸载 tmpfs 文件系统
umount /mnt/tmpfs
```



































