execute "systemctl daemon-reload" do
  action :nothing
end

execute "pacman -Sy" do
  action :nothing
end

define :yaourt do
  name = params[:name].shellescape
  execute "yaourt -S --noconfirm #{name}" do
    not_if "yaourt -Q #{name} || yaourt -Qg #{name}"
    user "cookpad"
  end
end

define :fstab, device: nil, mountpoint: nil, fstype: nil, options: nil, dump: 0, fsckorder: 0 do
  device = params[:device] || params[:name]
  mountpoint = params[:mountpoint]
  fstype = params[:fstype]
  mount_options = params[:options]
  dump = params[:dump]
  fsckorder = params[:fsckorder]

  new_fstab = "#{device} #{mountpoint} #{fstype} #{mount_options} #{dump} #{fsckorder}"

  file '/etc/fstab' do
    action :edit
    block do |content|
      if content =~ /^#{device}\s/
        content.gsub!(/^#{device}\s.*$/, new_fstab)
      else
        content.chomp!
        content << "\n#{new_fstab}\n"
      end
    end
  end
end

define :mount, mountpoint: nil do
  mountpoint = params[:mountpoint] || params[:name]

  execute "mount #{mountpoint}" do
    command "mount #{mountpoint}"
    not_if "mount | egrep -q '\\s#{mountpoint}\\s'"
  end
end


