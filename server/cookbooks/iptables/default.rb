node.reverse_merge!(
  iptables: {
  },
)

package "iptables" do
end

rule_source = node[:iptables][:rules_file].kind_of?(String) ? node[:iptables][:rules_file] : node[:hostname]

remote_file "/etc/iptables/iptables.rules" do
  source "files/etc/iptables/iptables.#{rule_source}"
  owner 'root'
  group 'wheel'
  mode  '0640'
end

remote_file "/etc/iptables/ip6tables.rules" do
  source "files/etc/iptables/ip6tables.#{rule_source}"
  owner 'root'
  group 'wheel'
  mode  '0640'
end

service "iptables" do
  action [:enable, :start]
end

service "ip6tables" do
  action [:enable, :start]
end
