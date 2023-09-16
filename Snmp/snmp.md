# Snmp

- 官网下载

    ```shell
    http://www.net-snmp.org/
    ```

- 安装前置软件包

    ```shell
    apt install libperl-dev libssl-dev -y
    ```


- 编译选项

    ```shell
    ./configure --prefix=/root/code/net-snmp-5.8/build --with-openssl=internal --with-cflags="-g -O0" --with-default-snmp-version=2 --with-sys-contact=who@where --with-sys-location=shio --with-persistent-directory=/root/code/net-snmp-5.8/build --with-logfile=/root/code/net-snmp-5.8/build
    
    # 静态编译模块
    --with-mib-modules=test
    ```
    
    

