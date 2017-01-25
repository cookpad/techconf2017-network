node.reverse_merge!(
  desired_hostname: 'dns',
  dns: {
    upstream: %w(10.200.165.220 10.200.131.194), # dns-001.aws, dns-002.aws
    interfaces: %w(127.0.0.1 10.200.17.10),
    log_queries: true,
  }
)

include_recipe '../roles/dns/default.rb'
