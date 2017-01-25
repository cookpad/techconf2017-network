node.reverse_merge!(
  desired_hostname: 'log-001',
  log: {
    directory: '/mnt/vol/log',
    workdir: '/mnt/vol/syslog-work',
  },
)

fstab '/dev/xvdf' do
  mountpoint '/mnt/vol'
  fstype 'ext4'
  options 'defaults,noatime'
end

directory '/mnt/vol' do
  owner 'root'
  group 'root'
  mode  '0755'
end

mount '/mnt/vol' do
end

include_recipe '../roles/log/default.rb'
