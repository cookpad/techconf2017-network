user 'cookpad' do
  uid 1001
  home '/home/cookpad'
  create_home true
end

directory '/home/cookpad' do
  owner 'cookpad'
  group 'cookpad'
  mode  '0755'
end

directory '/home/cookpad/.ssh' do
  owner 'cookpad'
  group 'cookpad'
  mode  '0700'
end

remote_file '/home/cookpad/.ssh/authorized_keys' do
  owner 'cookpad'
  group 'cookpad'
  mode  '0700'
end

remote_file '/etc/sudoers.d/cookpad' do
  owner 'root'
  group 'root'
  mode  '0700'
end
