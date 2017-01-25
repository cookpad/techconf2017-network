node.reverse_merge!(
  desired_hostname: 'dhcp-001',
)

include_recipe '../roles/dhcp/default.rb'
