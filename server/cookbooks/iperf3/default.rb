package "iperf3" do
end

remote_file "/etc/systemd/system/iperf3.service" do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :run, 'execute[systemctl daemon-reload]'
end


