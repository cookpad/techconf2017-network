node.reverse_merge!(
  desired_hostname: 'dns-002',
  dns: {
    upstream: '10.200.128.2', # aws vpc dns cache
    interfaces: %w(127.0.0.1 10.200.131.194),
    log_queries: false,
  }
)

include_recipe '../roles/dns/default.rb'
