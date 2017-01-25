node.reverse_merge!(
  desired_hostname: 'tp',
  systemd_nspawn: {
    bridge: 'br_server',
  },
)

file "/etc/systemd/network/default.network" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[Match]
Name=enp*

[Network]
Bridge=br0
VLAN=vlan_client
VLAN=vlan_mgmt
VLAN=vlan_server
  EOF
end

##

file "/etc/systemd/network/br0.netdev" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[NetDev]
Name=br0
Kind=bridge
  EOF
end

file "/etc/systemd/network/br0.network" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[Match]
Name=br0
  EOF
end

##

file "/etc/systemd/network/vlan_client.netdev" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[NetDev]
Name=vlan_client
Kind=vlan
[VLAN]
Id=100
  EOF
end

file "/etc/systemd/network/vlan_client.network" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[Match]
Name=vlan_client
[Network]
Bridge=br_client
  EOF
end


file "/etc/systemd/network/br_client.netdev" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[NetDev]
Name=br_client
Kind=bridge
  EOF
end

file "/etc/systemd/network/br_client.network" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[Match]
Name=br_client
  EOF
end

##

file "/etc/systemd/network/vlan_mgmt.netdev" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[NetDev]
Name=vlan_mgmt
Kind=vlan
[VLAN]
Id=200
  EOF
end

file "/etc/systemd/network/vlan_mgmt.network" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[Match]
Name=vlan_mgmt
[Network]
Bridge=br_mgmt
  EOF
end


file "/etc/systemd/network/br_mgmt.netdev" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[NetDev]
Name=br_mgmt
Kind=bridge
  EOF
end

file "/etc/systemd/network/br_mgmt.network" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[Match]
Name=br_mgmt

[Network]
Address=10.200.16.20/24
DNS=10.200.165.220 # dns-001.aws

[Route]
Destination=0.0.0.0/0
Metric=1100
Gateway=10.200.16.1
  EOF
end

##

file "/etc/systemd/network/vlan_server.netdev" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[NetDev]
Name=vlan_server
Kind=vlan
[VLAN]
Id=210
  EOF
end

file "/etc/systemd/network/vlan_server.network" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[Match]
Name=vlan_server
[Network]
Bridge=br_server
  EOF
end


file "/etc/systemd/network/br_server.netdev" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[NetDev]
Name=br_server
Kind=bridge
  EOF
end

file "/etc/systemd/network/br_server.network" do
  owner 'root'
  group 'root'
  mode  '0644'
  content <<-EOF
[Match]
Name=br_server
  EOF
end

##

include_recipe '../roles/base/default.rb'
include_recipe '../cookbooks/systemd-nspawn/default.rb'

systemd_nspawn "dns" do
end
