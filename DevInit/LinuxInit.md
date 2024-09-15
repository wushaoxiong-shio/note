# 环境搭建

- Debian镜像下载

> https://cdimage.debian.org/cdimage/archive/

- vm网卡地址设置

    > vm虚拟网卡默认占用子网的第一个地址，所以默认情况下，子网的网关不能使用第一个地址
    >
    > 如：NAT虚拟网卡 VMnet8，子网设置为 10.15.20.0，则 VMnet8 默认地址为 10.15.20.1
    >
    > 此时该子网的1号地址被占用，网关不能设置为子网1号地址，否则虚拟机将不能和宿主机通信，ping不通
    >
    > VMnet8 默认为静态IP模式，为子网的1号地址，可以修改成其他地址

## 一、开启远程连接

- 编辑配置文件

```shell
apt install vim -y
vim /etc/ssh/sshd_config
```

- 修改设置

```shell
PermitRootLogin yes
PubkeyAuthentication yes
```

- 重启 ssh

```shell
systemctl restart ssh
```

- 查看 IP 进行远程 ssh 登录

> ifconfig 或者 ip a

## 二、更换软件源

- 编辑配置文件

```shell
vim /etc/apt/sources.list
```

- 替换成如下

```shell
deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb https://mirrors.aliyun.com/debian-security/ bullseye-security main
deb-src https://mirrors.aliyun.com/debian-security/ bullseye-security main
deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
```

- 软件更新

```shell
apt update -y && apt upgrade -y
```

- 下载常用软件

```shell
apt install gcc g++ git gdb make cmake bear clangd-16 htop sshpass tree zsh curl wget vim ssh zip unzip -y
apt install build-essential linux-headers-$(uname -r) python3-dev libncurses-dev ripgrep net-tools dwarves -y
apt install libperl-dev libssl-dev flex bison libelf-dev bc iptables conntrack tcpdump linux-perf strace -y
apt install ethtool -y
```

    

## 三、配置静态IP

- 编辑配置文件

```shell
vim /etc/network/interfaces
```

- 在文件下追加

```shell
auto ens192
iface ens192 inet static
address 10.20.10.55
gateway 10.20.10.1
netmask 255.255.255.0
dns-serversname 10.20.10.1
```

- 重启系统，配置生效

```shell
reboot
```

## 四、设置终端

- 设置终端光标颜色

```shell
"cursorColor": "#7673BB"

# iterm2
Appearance -> General -> Theme -> Minimal
Profiles -> Terminal -> shell Integration -> show mark indicators


```

- 开启系统代理，打开配置文件添加环境变量

```shell
vim /etc/profile
export http_proxy=http://10.20.10.30:7890
export https_proxy=http://10.20.10.30:7890
# 执行 source /etc/profile 配置生效
```
    
- 测试代理是否开启

```shell
curl www.google.com
# 有返回结果输出，则说明已开启代理
```

- 切换zsh为默认的终端

```shell
chsh -s /bin/zsh
```

- curl 安装 on-my-zsh

```shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- 安装 zsh 插件

```shell
cd /root/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions.git
```

- 编辑 zsh 配置文件 ~/.zshrc，并添加开启代理环境变量

```shell
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
export http_proxy=http://10.20.10.206:7890
export https_proxy=http://10.20.10.206:7890
# 执行 source ~/.zshrc 配置生效
```

## 五、设置 ssh

- 编辑配置文件

```shell
vim /etc/ssh/sshd_config
```

- 修改设置

```shell
AuthorizedKeysFile	.ssh/authorized_keys
ClientAliveInterval 60
ClientAliveCountMax 6000
```

- 生成本地的 ssh 密匙，连续按 Enter 键

```shell
ssh-keygen -t rsa
# 密匙生成在 ~/.ssh/id_rsa.pub 位置
```

- 将远端的 ssh 密匙复制添加到 ～/.ssh/authorized_keys 中

- 清除指定IP地址的本地ssh连接缓存

```shell
ssh-keygen -R ipadress
```

- 配置ssh跳板机
```shell
# 配置文件添加开关
GatewayPorts yes

# 跳板机IP 172.16.254.61，不能配置免密
ssh -L 0.0.0.0:23:172.16.254.201:22 -Nf 172.16.254.61
```

## 六、配置 git

- 添加用户名和邮箱

```shell
git config --global user.name "shio"
git config --global user.email "wushaoxiong.shio@gmail.com"
```

- 查看git配置

```shell
git config user.name
git config user.email
git config --list
```

## 七、跳过开机GRUB选择界面

```shell
# 编辑 grub 配置文件
vim /etc/default/grub
# 将 grub 超时时间设置为0
GRUB_TIMEOUT=0

# 设置网口名从 eth0 开始
GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"

# 保存 grub 配置，使其生效
update-grub
```

## 八、bear 3.0版本需配置环回地址不走代理

```shell
export no_proxy=localhost,127.0.0.1

# tmux 通过 -d 参数后台执行
# tmux 发送命令给指定会话执行
# tmux send-keys -t build "cd ${workspaceFolder} && /tool/bear -l/tool/libear.so make -j8" Enter
```

# 九、设置 update-alternatives

~~~shell
# 先修改 /usr/bin/gcc 为 /usr/bin/gcc-10 ，防止覆盖，再创建统一链接 /usr/bin/gcc
update-alternatives --install /usr/bin/gcc gcc /usr/bin/x86_64-linux-gnu-gcc-10 50
update-alternatives --install /usr/bin/gcc gcc /usr/bin/x86_64-linux-gnu-gcc-9 50

# update-alternatives --config gcc 选择版本号

# update-alternatives --help 查看帮助手册
~~~

# 设置开启自启动脚步
```shell
cd /etc/init.d/
vim test
chmod +x test
update-rc.d test defaults

# debian要求文件头部有启动信息，脚本顶部添加，可以在当前目录其他的脚步里面拷贝过来
# 字段中间要用 tab 而不能是四个空格
# Provides 字段要唯一
#!/bin/sh
### BEGIN INIT INFO
# Provides:          test
... ...
### END INIT INFO

# 最后一定要正常退出
exit 0

# 取消自启动
update-rc.d -f test remove
```

# 配置示例
```shell
vim /etc/init.d/netns_init

#! /bin/sh

### BEGIN INIT INFO
# Provides:		netns_init
# Required-Start:
# Required-Stop:
# Default-Start:
# Default-Stop:		2 3 4 5
# Short-Description:	netns_init
### END INIT INFO

exec > /tmp/netns_init.log 2>&1
set -ex

ip netns add ns1
ip link set dev eth1 netns ns1
ip netns exec ns1 ip addr add 1.1.1.10/24 dev eth1
ip netns exec ns1 ip link set eth1 up

ip netns add ns2
ip link set dev eth2 netns ns2
ip netns exec ns2 ip addr add 2.2.2.20/24 dev eth2
ip netns exec ns2 ip link set eth2 up

exit 0
```

## 配置 Telnet
```shell
# 默认端口 23
apt install xinetd telnetd -y

# 编辑配置文件
vim /etc/xinetd.d/telnet

service telnet
{
    disable = no
    flags = REUSE
    socket_type = stream
    wait = no
    user = root
    server = /usr/sbin/telnetd
    log_on_failure += USERID
}

# 开启Telnetd
systemctl restart xinetd

# 添加开机自启动
systemctl enable xinetd
```