node.reverse_merge!(
  zabbix_agent: {
    server: 'zabbix-001.aws.nw.techconf.cookpad.com',
  },
)

package 'zabbix-agent'

template '/etc/zabbix/zabbix_agentd.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :restart, 'service[zabbix-agentd]'
end

directory '/etc/zabbix/zabbix_agentd.conf.d' do
  owner 'root'
  group 'root'
  mode  '0755'
end

%w(
  linux
).each do |_|
  remote_file "/etc/zabbix/zabbix_agentd.conf.d/#{_}.conf" do
    owner 'root'
    group 'root'
    mode  '0644'
    notifies :restart, 'service[zabbix-agentd]'
  end
end

service 'zabbix-agentd' do
  action [:enable, :start]
end
