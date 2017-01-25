node.reverse_merge!(
  systemd_nspawn: {
    bridge: 'br0',
  },
)

package "arch-install-scripts" do
end

directory "/etc/systemd/system/systemd-nspawn@.service.d" do
  owner 'root'
  group 'root'
  mode  '0755'
end

template "/etc/systemd/system/systemd-nspawn@.service.d/bridge.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
end

service "machines.target" do
  action :enable
end

directory '/var/lib/machines' do
  owner 'root'
  group 'root'
  mode  '0755'
end

define :systemd_nspawn do
  service "systemd-nspawn@#{params[:name]}" do
    action :enable
  end
end
