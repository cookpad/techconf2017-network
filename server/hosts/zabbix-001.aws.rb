node.reverse_merge!(
  desired_hostname: 'zabbix-001',
)

include_recipe '../roles/zabbix-server/default.rb'
