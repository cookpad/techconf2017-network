node.reverse_merge!(
  desired_hostname: 'bastion',
)

include_recipe '../roles/bastion/default.rb'

