## GDB
```shell
应用程序级别的调试

```

## Valgrind
```shell
内存调试和性能分析

```


## Perf
```shell
性能分析

```

## SystemTap
```shell
内核级别的调试和性能分析

```

## LTTng
```shell
跟踪和分析系统性能

```


## ftrace
```shell
Linux内核内置的跟踪框架，用于分析内核行为

```

## eBPF
```shell

```

## DTrace
```shell
动态跟踪和分析

```

## BCC
```shell
高级内核追踪和性能分析

# 二进制安装，安装下来没有 tools 工具
apt install -y bpfcc-tools libbpfcc libbpfcc-dev linux-headers-$(uname -r)

# 源码安装默认安装在 /usr/share/bcc
git clone https://github.com/iovisor/bcc.git

apt install -y netperf libpolly-14-dev liblzma-dev libdebuginfod-dev \
	arping bison clang-format cmake dh-python \
	dpkg-dev pkg-kde-tools ethtool flex inetutils-ping iperf \
	libbpf-dev libclang-dev libclang-cpp-dev libedit-dev libelf-dev \
	libfl-dev libzip-dev linux-libc-dev llvm-dev libluajit-5.1-dev \
	luajit python3-netaddr python3-pyroute2 python3-setuptools python3

mkdir bcc/build; cd bcc/build
cmake ..
make -j4 && make install


```

## DebugFS
```shell
内核调试文件系统

```

## Kdump/Kexec
```shell
内核崩溃转储分析

```

