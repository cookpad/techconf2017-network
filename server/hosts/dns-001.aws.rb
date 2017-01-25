node.reverse_merge!(
  desired_hostname: 'dns-001',
  dns: {
    upstream: '10.200.128.2', # aws vpc dns cache
    interfaces: %w(127.0.0.1 10.200.165.220),
    log_queries: false,
  }
)

include_recipe '../roles/dns/default.rb'
