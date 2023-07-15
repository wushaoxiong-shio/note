# Redis

``` shell
# 下载代码，进入目录，设置安装路径
make -j4 && make PREFIX=/root/DB-Server/redis-7.0.12/ install

# 将源码目录下的 redis.conf 复制到安装目录
# 编辑 redis.conf
# 设置redis为守护进程
daemonize yes
# 修改 bind 地址
bind 10.20.10.60 127.0.0.1
# 保护模式选项
# 设置为关闭(no)时可以通过 IP、port、用户名<default>，从任意IP不需要密码直接连接访问
# 如果设置了密码，连接时可以不填用户名
protected-mode no
# 设置为开启(yes)，且没有设置密码时，则只能通过127.0.0.1地址本地连接数据库，其他IP连接则提示没有权限
# 其他ip要连接，则必须设置连接密码，连接时需要带上密码
requirepass qweasd

# 启动服务
./redis-server ./redis.conf
# 客户端连接
./redis-cli -h 10.20.10.60 -p 6379
# 使用 -a 带上连接密码
./redis-cli -h 10.20.10.60 -p 6379 -a qweasd

# 查看用户信息
acl list

# 关闭服务 使用 redis-cli 连接上，执行 shutdown 命令
./redis-cli -h 10.20.10.60 -p 6379 -a qweasd shutdown
# 客户端连接后，使用 quit 命令退出

```



