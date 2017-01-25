package "zabbix-server" do
end

package 'net-snmp' do
end

package 'iksemel' do
end

package 'fping' do
end


#sudo -u postgres psql
#  create database zabbix;
#  create role zabbix with login;
#  \q

#cd /etc/zabbix/database/postgresql
#sudo -u zabbix psql zabbix < schema.sql
#sudo -u zabbix psql zabbix < images.sql
#sudo -u zabbix psql zabbix < data.sql


