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
    apt update -y
    apt upgrade -y
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
    ```

- 终端开启彩色，下面的语句取消注释

    ```shell
    vim ~/.bashrc
    
    export LS_OPTIONS='--color=auto'
    eval "$(dircolors)"
    alias ls='ls $LS_OPTIONS'
    alias ll='ls $LS_OPTIONS -l'
    alias l='ls $LS_OPTIONS -lA'
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
    
    # 执行 source ~/.bashrc 配置生效
    ```

- 开启系统代理，打开配置文件添加环境变量

    ```shell
    vim /etc/profile
    
    export http_proxy=http://10.20.10.206:7890
    export https_proxy=http://10.20.10.206:7890
    
    # 执行 source /etc/profile 配置生效
    apt install curl -y
    ```

- 测试代理是否开启

    ```shell
    curl www.google.com
    # 有返回结果输出，则说明已开启代理
    ```

- 安装 zsh

    ```shell
    apt install -y zsh
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

## 七、安装常用软件

```shell
apt install gcc g++ make git gdb gcc-9 g++-9 htop sshpass bear tree -y
```

