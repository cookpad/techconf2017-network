yaourt "kea" do
end

remote_file "/etc/tmpfiles.d/kea.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
end

directory '/run/kea' do
  owner 'root'
  group 'root'
  mode  '0755'
end

remote_file "/etc/systemd/system/kea-dhcp4.service" do
  owner 'root'
  group 'root'
  mode  '0644'

  notifies :run, 'execute[systemctl daemon-reload]'
end

directory "/var/db/kea" do
  owner 'root'
  group 'root'
  mode  '0755'
end


directory "/var/log/kea" do
  owner 'root'
  group 'root'
  mode  '0755'
end
