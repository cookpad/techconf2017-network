execute 'pacman-key --recv-keys C48DBD97 && pacman-key --lsign-key C48DBD97' do
  action :nothing
  notifies :run, 'execute[pacman -Sy]'
end

file '/etc/pacman.conf' do
  action :edit
  server = "[aur-eagletmt]\nServer = http://arch.wanko.cc/$repo/os/$arch"

  block do |content|
    if content =~ /^\[aur-eagletmt\]/
      content.gsub!(/^\[aur-eagletmt\].*\n.*$/, server)
    else
      content << server << "\n"
    end
  end

  notifies :run, 'execute[pacman-key --recv-keys C48DBD97 && pacman-key --lsign-key C48DBD97]'
end
