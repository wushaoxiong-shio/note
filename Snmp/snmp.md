# Snmp

- 官网下载

    ```shell
    http://www.net-snmp.org/
    ```

- 安装前置软件包

    ```shell
    apt install libperl-dev -y
    ```


- 编译选项

    ```shell
    ./configure --prefix=/root/snmp-bin --enable-ipv6 --with-openssl --with-cflags="-g -O0" --with-mib-modules=test
    ```

    

