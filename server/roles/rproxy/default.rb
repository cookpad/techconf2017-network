include_recipe '../../roles/base/default.rb'
include_recipe '../../cookbooks/nginx/default.rb'

%w(
  default
  zabbix
  grafana
  identify
  wlc
).each do |_|
  remote_file "/etc/nginx/conf.d/#{_}.conf" do
    owner 'root'
    group 'root'
    mode  '0644'
    notifies :reload, 'service[nginx]'
  end
end

directory '/etc/nginx/public/identify' do
  owner 'root'
  group 'root'
  mode  '0755'
end

remote_file '/etc/nginx/public/identify/index.html' do
  owner 'root'
  group 'root'
  mode  '0644'
end

service 'nginx' do
  action [:enable, :start]
end
