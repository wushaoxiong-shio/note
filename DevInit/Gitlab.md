# GitLab

```shell
# 下载安装deb包
dpkg -i gitlab-ce_16.0.7-ce.0_amd64.deb
# 配置文件
vim /etc/gitlab/gitlab.rb
# 修改地址端口，默认8080
external_url 'http://10.20.10.55:7990'
# 性能优化参数，防止内存占用太多
# 优化参考官方文档 https://docs.gitlab.cn/16.0/omnibus/settings/memory_constrained_envs.html

external_url 'http://10.20.10.70:7700'

puma['exporter_enabled'] = false
prometheus['enable'] = false
prometheus_monitoring['enable'] = false
node_exporter['enable'] = false
redis_exporter['enable'] = false
gitlab_exporter['enable'] = false
postgres_exporter['enable'] = false
pgbouncer_exporter['enable'] = false

puma['worker_processes'] = 0
redis['io_threads'] = 2
nginx['worker_processes'] = 2
sidekiq['max_concurrency'] = 5
postgresql['shared_buffers'] = "128MB"
postgresql['max_worker_processes'] = 2

gitaly['env'] = {
  'MALLOC_CONF' => 'dirty_decay_ms:1000,muzzy_decay_ms:1000',
  'GITALY_COMMAND_SPAWN_MAX_PARALLEL' => '2'
}
gitlab_rails['env'] = {
  'MALLOC_CONF' => 'dirty_decay_ms:1000,muzzy_decay_ms:1000'
}


# 重新加载配置文件
gitlab-ctl reconfigure
# 开启gitlab服务
gitlab-ctl start / restart
# 查看状态
gitlab-ctl status
# 查看初始化root密码，第一次登录后修改密码
cat /etc/gitlab/initial_root_password
# 登录后修改密码
# 前往 管理员 -> 设置 -> 指标与分析
# 关闭 <指标 - Prometheus>
# 关闭 <指标 - Grafana>
# 关闭 <分析 - 性能栏>
# 关闭 <使用情况统计> 的版本检查和服务Ping
```

