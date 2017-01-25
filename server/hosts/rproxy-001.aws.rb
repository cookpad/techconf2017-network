node.reverse_merge!(
  desired_hostname: 'rproxy-001',
)

include_recipe '../roles/rproxy/default.rb'
