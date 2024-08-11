# Debian 11


```shell

apt install flex bison libelf-dev libssl-dev bc -y

make distclean or make mrproper

cp /boot/config-$(uname -r) .config or make menuconfig
# default
make x86_64_defconfig

cp /boot/config-$(uname -r) .config

make menuconfig

# 修改编译选项
vim .config
# CONFIG_DEBUG_INFO_BTF 调试、性能分析工具开关，编译需要的依赖库在 Debian上版本太低，不好安装，用不到 BTF 直接关闭即可
CONFIG_DEBUG_INFO_BTF=n
# 字段值置空
CONFIG_SYSTEM_TRUSTED_KEYS=""


# 直接源码本地安装
# 编译低版本 5.1x 的内核不能使用高版本的编译器，需要11及以下，不然会报 -Wno-error=use-after-free
# 手动指定使用 gcc-11
make -j12 HOSTCC=gcc-11 CC=gcc-11
make modules_install
make install

# make install 会自动执行  update-grub
# 不想更新 grup 则手动生成 initrd.img
# 重新创建
update-initramfs -c -k 5.10.25 -b /boot
# 更新
update-initramfs -u -k 5.10.25 -b /boot

# 将 initrd.img 和 vmlinuz 替换到其他设备上的 /boot 
# 将 /lib/modules/<version> 打包到其他设备解压
# update-grub


# 生成索引
bear -- make -C /root/code/linux-5.10.26 M=`pwd` -j12

# 
alias mkernel='make -j12 && make modules_install && make install && update-grub'



## 使用 tmpfs 虚拟文件系统加快编译


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

# 添加重启生效
vim /etc/fstab
# 添加一行
tmpfs   /mnt/tmpfs  tmpfs   defaults,size=2G    0   0
# 保存重启后生效

```

# 安装编译 GCC
```shell

# 官网下载源码
# 安装依赖库
cd gcc
./contrib/download_prerequisites

./configure --prefix=/usr/local/gcc-8.4 --disable-multilib --enable-languages=c,c++

```

## 编译安装 DPDK
```shell
# 虚拟机网卡驱动要改成 vmxnet3 在 Debian.vmx 中改
# 内核编译要打开 CONFIG_VFIO_NOIOMMU 选项

apt install meson pkg-config python3-pip ninja-build libnuma-dev python3-pyelftools -y

meson setup build --prefix=/root/code/dpdk/install

cd build

ninja -j32
ninja install

export PKG_CONFIG_PATH=/root/code/dpdk/install/lib/x86_64-linux-gnu/pkgconfig:$PKG_CONFIG_PATH

# cd build
# meson configure -Dexamples=helloworld
# ninja
# examples/dpdk-helloworld -l 0-1 -n 2


# vim /etc/default/grub，VM虚拟机需要加 nopku transparent_hugepage=never
GRUB_CMDLINE_LINUX="nopku transparent_hugepage=never default_hugepagesz=1G hugepagesz=1G hugepages=2"

update-grub

mkdir -p /mnt/hugemem
mount -t hugetlbfs nodev /mnt/hugemem

# vim /etc/fstab
nodev /mnt/hugemem hugetlbfs defaults 0 0

modprobe vfio enable_unsafe_noiommu_mode=1
modprobe vfio-pci
/root/code/dpdk/usertools/dpdk-devbind.py --status
#/root/code/dpdk/usertools/dpdk-devbind.py --bind=vfio-pci 04:00.1
ifconfig ens33 down
/root/code/dpdk/usertools/dpdk-devbind.py --bind=vfio-pci ens33


```

## dperf

```shell
# 检查中断绑定（IRQ Affinity）
# 中断绑定（IRQ Affinity）决定了哪些 CPU 核心处理哪些中断,如果中断没有均匀分布到多个 CPU 核心，会导致负载集中在一个核心上
# 查看 中断号 结果在第一列
cat /proc/interrupts

# 通过写入 `/proc/irq/<IRQ-number>/smp_affinity` 文件来设置中断绑定
echo ff > /proc/irq/16/smp_affinity
# ff 表示八个 CPU 核心（0-7）具体的掩码可以根据需要调整

# 使用 `ethtool` 查看和配置 RSS
ethtool -x ens224
# 将接收和发送队列都设置为8
ethtool -L ens224 combined 8 

# RPS 将网络接收流量在多个 CPU 核心之间分配
# 配置 Receive Packet Steering (RPS) 为每个接收队列配置 RPS 假设有 8 个接收队列
# 设置 rps
echo ffffffff > /sys/class/net/ens224/queues/rx-0/rps_cpus
echo ffffffff > /sys/class/net/ens224/queues/rx-1/rps_cpus
echo ffffffff > /sys/class/net/ens224/queues/rx-2/rps_cpus
echo ffffffff > /sys/class/net/ens224/queues/rx-3/rps_cpus
echo ffffffff > /sys/class/net/ens224/queues/rx-4/rps_cpus
echo ffffffff > /sys/class/net/ens224/queues/rx-5/rps_cpus
echo ffffffff > /sys/class/net/ens224/queues/rx-6/rps_cpus
echo ffffffff > /sys/class/net/ens224/queues/rx-7/rps_cpus



```





























