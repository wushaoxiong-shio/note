# VIM 配置

## 一、安装 vim-plug

- 下载 vim-plug

    > git clone https://github.com/junegunn/vim-plug.git

- 建立文件夹

> mkdir ~/.vim
>
> cd ~/.vim/
>
> mkdir autoload plugged plugin

- 安装 vim-plug

> mv ~/vim-plug/plug.vim ~/.vim/autoload

## 二、源码编译 VIM

- 软件源安装的 vim 没有配置 python 模块，需要自行编译安装

> 安装前置依赖
>
> apt install -y python3-dev libncurses-dev
>
> git clone https://github.com/vim/vim.git

- 编译安装

> 先删除已有的 vim
>
> apt remove -y vim

> cd ./vim

```shell
./configure --with-features=huge --enable-multibyte --enable-python3interp=yes --prefix=/usr/local/vim9 --enable-cscope
```



> make && make install
>
> ln -s /usr/local/vim9/bin/vim /usr/bin/vim
>
> vim --version 可查看是否成功安装了python3模块

## 三、安装clang

### 1、离线包安装

 - 下载12.0.1版本的clang+llvm-12.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz

    > curl -OL https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.1/clang+llvm-12.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz

- 解压并安装相应目录

> xz -d ./xx.zip
>
> tar -xvf ./xx.zip
>
> mv ./xx /usr/local/clang

- 添加环境变量

> export PATH=/usr/local/clang/bin:$PATH

### 2、更新软件源在线安装

- 下载安装脚本，赋予权限

> wget https://apt.llvm.org/llvm.sh
>
> chmod +x llvm.sh

- 安装需要的版本，以 14 版本为例

> ./llvm.sh 14

- 安装后在 /usr/bin/clang-14，需要手动修改下名称

> mv /usr/bin/clang-14 /usr/bin/clang
>
> mv /usr/bin/clangd-14 /usr/bin/clangd

## 四、Cmake 二进制安装

- 下离线包

    ```shell
    curl -OL https://github.com/Kitware/CMake/releases/download/v3.27.0-rc5/cmake-3.27.0-rc5-linux-x86_64.tar.gz
    ```

- 解压

> tar -xvf ./xx.tar.gz
>
> mv ./xx /usr/local/cmake

- 创建软链接

> ln -s /usr/local/cmake/bin/cmake /usr/bin/cmake

## 五、Nodejs二进制安装

- 下载二进制包

> curl -OL https://nodejs.org/dist/v18.17.1/node-v18.17.1-linux-x64.tar.xz

- 解压安装

> tar -zxvf ./xx.tar.gz
>
> mv ./xx /usr/local/nodejs

- 添加环境变量，nodejs不能通过软链接方式安装

> export PATH=/usr/local/nodejs/bin:$PATH

## 六、VIM插件安装

- 全局安装 yarn

> npm install -g yarn

- 安装 vim 插件

> vim 的命令行执行 PlugInstall

- 安装 LeaderF加速搜索插件C语言编译

> LeaderfInstallCExtension

- 安装其他组件

> apt install ripgrep universal-ctags -y

## 七、安装 coc 配件

- 进入到coc-nvim目录下，安装yarn依赖


> cd ~/.vim/plugged/coc.nvim/
> yarn install
> yarn build

- 安装 coc 插件

    > vim 命令行执行 CocInstall coc-json coc-clangd coc-cmake coc-pairs coc-snippets

## 八、gtags源码安装

- 下载源码

    > curl -OL https://ftp.gnu.org/pub/gnu/global/global-6.6.9.tar.gz

- 编译安装

    > cd ./gtags
    > ./configure
    > make && make install

## 九、配置 CocConfig 文件

> vim 命令执行 CocConfig
>
> 将配置项复制粘贴，退出保存  