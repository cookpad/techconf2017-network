node.reverse_merge!(
  ssh: {
    port: [22, 1022],
  },
)

include_recipe '../../roles/base/default.rb'
include_recipe '../../cookbooks/iptables/default.rb'

service "iperf3" do
  action [:enable, :start]
end
