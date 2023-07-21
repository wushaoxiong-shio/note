# GitLab

```shell
# 下载安装deb包
dpkg -i gitlab-ce_16.0.7-ce.0_amd64.deb
# 配置文件
vim /etc/gitlab/gitlab.rb
# 修改地址端口，默认8080
external_url 'http://10.20.10.55:7990'
# 重新加载配置文件
gitlab-ctl reconfigure
# 开启gitlab服务
gitlab-ctl start
# 查看状态
gitlab-ctl status
# 查看初始化root密码，第一次登录后修改密码
cat /etc/gitlab/initial_root_password
```

