node.reverse_merge!(
  dns: {
    threads: 2,
    upstream: nil,
    interfaces: %w(0.0.0.0 ::0),
    log_queries: false,
  },
)

1.upto(100) do |i|
  node[:dns][:slab] = 2**i
  if node[:dns][:slab] >= node[:dns][:threads]
    break
  end
end

include_recipe '../../roles/base/default.rb'
include_recipe '../../cookbooks/unbound/default.rb'
include_recipe '../../cookbooks/zabbix-userparameter-unbound/default.rb'

template "/etc/unbound/unbound.conf" do
  owner "root"
  group "root"
  mode  "0644"
end

directory "/var/log/unbound" do
  owner "unbound"
  group "unbound"
  mode  "0755"
end

service "unbound" do
  action [:enable, :start]
end
