include_recipe '../nginx/default.rb'

remote_file '/etc/nginx/conf.d/php-fpm.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
end

package "php"
package "php-fpm"
package "php-gd"
package "php-pgsql"

template "/etc/php/php.ini" do
  owner 'root'
  group 'root'
  mode  '0644'
end

template "/etc/php/php-fpm.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
end

template "/etc/php/php-fpm.d/www.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
end
