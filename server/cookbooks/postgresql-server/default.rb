package "postgresql" do
end

directory node[:postgresql_server][:root] do
  owner 'postgres'
  group 'postgres'
  mode  '0755'
end

directory "/etc/systemd/system/postgresql.service.d" do
  owner 'root'
  group 'root'
  mode  '0755'
end

file "/etc/systemd/system/postgresql.service.d/pgroot.conf" do
  owner 'root'
  group 'root'
  mode  '0755'
  content <<-EOF
[Service]
Environment=PGROOT=#{node[:postgresql_server][:root]}
PIDFile=#{node[:postgresql_server][:root]}/data/postmaster.pid
  EOF
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

execute "postgresql initdb" do
  action :nothing
  user "postgres"
  command "initdb --locale en_US.UTF-8 -E UTF8 -D #{node[:postgresql_server][:root].shellescape}/data"
end

directory File.join(node[:postgresql_server][:root], "data") do
  owner 'postgres'
  group 'postgres'
  mode  '0750'
  notifies :run, "execute[postgresql initdb]"
end

if node[:postgresql_server][:root] != '/var/lib/postgres'
  execute 'remove /var/lib/postgres' do
    command "mv /var/lib/postgres{,.bak}"
    not_if "test -L /var/lib/postgres"
  end

  link '/var/lib/postgres' do
    to node[:postgresql_server][:root]
  end
end

service "postgresql.service" do
  action [:enable, :start]
end
