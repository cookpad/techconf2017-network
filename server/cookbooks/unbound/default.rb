package "unbound" do
end

execute "unbound-control-setup" do
  user "root"
  not_if "test -e /etc/unbound/unbound_control.key"
end
