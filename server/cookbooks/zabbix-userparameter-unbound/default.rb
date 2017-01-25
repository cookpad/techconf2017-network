remote_file "/etc/sudoers.d/zabbix-unbound" do
  owner 'root'
  group 'root'
  mode  '0440'
end

remote_file "/usr/bin/ckpd-zabbix-send-unbound" do
  owner 'root'
  group 'root'
  mode  '0755'
end

remote_file "/etc/zabbix/zabbix_agentd.conf.d/unbound.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :restart, 'service[zabbix-agentd]'
end
