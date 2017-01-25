remote_file "/etc/sudoers.d/zabbix-kea" do
  owner 'root'
  group 'root'
  mode  '0640'
end

remote_file "/usr/bin/ckpd-kea-stats" do
  owner 'root'
  group 'root'
  mode  '0755'
end

remote_file "/usr/bin/ckpd-zabbix-kea-subnet4" do
  owner 'root'
  group 'root'
  mode  '0755'
end

remote_file "/etc/zabbix/zabbix_agentd.conf.d/kea.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :restart, 'service[zabbix-agentd]'
end
