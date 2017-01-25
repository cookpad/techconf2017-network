node.reverse_merge!(
  multilib: run_command("grep '^\\[multilib\\]' /etc/pacman.conf", error: false).exit_status == 0,
  in_container: run_command("systemd-detect-virt --container", error: false).exit_status == 0,
  base: {
    zabbix_agent: true,
  },
)

if node[:desired_hostname] && node[:desired_hostname] != node[:hostname]
  execute "set hostname" do
    command "hostnamectl set-hostname #{node[:desired_hostname]}"
  end
  node[:hostname] = node[:desired_hostname]
end

package "sudo" do
end

include_recipe '../../cookbooks/iperf3/default.rb'

package "bind-tools" do
end

package "sysstat" do
end

package "dstat" do
end

package "vim" do
end

package "mtr" do
end

package "tcpdump" do
end

package "gnu-netcat" do
end

package "socat" do
end

package "traceroute" do
end

package "htop" do
end

package "jq" do
end

package "git" do
end

package "ruby" do
end

if node[:multilib]
  package "gcc-multilib" do
  end
else
  package "gcc" do
  end
end

%w(autoconf automake binutils bison fakeroot file findutils
flex gawk gettext grep groff gzip libtool m4 make pacman
patch pkg-config sed sudo texinfo util-linux which).each do |pkg|
  package pkg do
  end
end

package "btrfs-progs" do
end

include_recipe '../../cookbooks/cookpad-user/default.rb'

execute "install yaourt" do
  command "rm -rf /tmp/mitamae-install-yaourt; " +
          "mkdir /tmp/mitamae-install-yaourt && " +
          "cd /tmp/mitamae-install-yaourt &&" +
          "git clone https://aur.archlinux.org/package-query.git && " +
          "chgrp cookpad package-query && chmod 775 package-query && " +
          "cd package-query && " +
          "su cookpad -s /bin/bash -c 'makepkg --noconfirm -si' && " +
          "cd .. && " +
          "git clone https://aur.archlinux.org/yaourt.git && " +
          "chgrp cookpad yaourt && chmod 775 yaourt && " +
          "cd yaourt && " +
          "su cookpad -s /bin/bash -c 'makepkg --noconfirm -si' && " +
          "cd /tmp; rm -rf /tmp/mitamae-install-yaourt"

  not_if "test -x /usr/bin/yaourt"
end

include_recipe '../../cookbooks/arch-wanko-cc/default.rb'

include_recipe '../../cookbooks/sshd/default.rb'

template "/etc/systemd/timesyncd.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
end

unless node[:in_container]
  service "systemd-timesyncd" do
    action [:enable, :start]
  end
end

if node[:base][:zabbix_agent]
  include_recipe '../../cookbooks/zabbix-agent/default.rb'
end

file '/root/.ssh/authorized_keys' do
  action :delete
end
