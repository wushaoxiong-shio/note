# MySQL

```shell
# 下载
# MySQL官网找到 MySQL Community (GPL) Downloads
# 进入 MySQL APT Repository
# 下载 更新软件仓库包
mysql-apt-config_0.8.25-1_all.deb
# 安装更新包
dpkg -i mysql-apt-config_0.8.25-1_all.deb

# 进入配置界面，第一个选项服务与集群里面，选择mysql-server服务，不选集群，第二第三项都关闭设置为disenable
# 选择强密码模式，设置root密码
# 软件仓库源更新
apt update -y
apt upgrade -y
# 查看刚才添加的 mysql-server 官网包，没有default前缀
apt search mysql-server
# 安装mysql-server
apt install mysql-server -y
# 查看运行状态
systemctl status mysql
# 登录
mysql -u root -p

# 创建用户赋予权限
create user 'shio'@'%' identified by 'qweasd';
grant all privileges on *.* to 'shio'@'%' with grant option;
flush privileges;
```

