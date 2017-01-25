node.reverse_merge!(
  log: {
    directory: '/syslog',
    workdir: '/var/spool/rsyslog',
  }
)

include_recipe '../../cookbooks/rsyslog/default.rb'

directory node[:log][:workdir] do
  owner 'root'
  group 'root'
  mode  '0755'
end

directory node[:log][:directory] do
  owner 'root'
  group 'root'
  mode  '0755'
end

template '/etc/rsyslog.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
end
