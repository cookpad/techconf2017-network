# TechConf 2017: The Network

## Files

- `nwconf/`: confiuration for network switches and routers.
- `server/`: mitamae recipes for Linux servers.
  - `site.rb`: Helper methods and definitions for mitamae.
  - `cookbooks/`: Recipes of package or softwares.
  - `roles/`: Recipes for specific role; use cookbooks and adding some specific configuration.
  - `hosts/`: Recipes for every hosts; Set variables and use roles.
- `zabbix/`: Zabbix templates (Linux, Cisco switch/routers, Cisco WLC, ISC Kea, Unbound)
- `Routefile`: file for [roadworker](https://github.com/winebarrel/roadworker) to manage Route 53 hosted zones
- `Groupfile`: file for [piculet](https://github.com/winebarrel/piculet) to manage EC2 security groups
- `nwconf-filter.sh`, `nwconf-collect.sh`: Shell script to collect `show running-config` from Cisco boxes with proper filtering.

## operations

### mitamae

```
# Apply server/xxx.yyy.rb to xxx.yyy.nw.techconf.cookpad.com
./server/apply.sh xxx.yyy

# Custom SSH options
./server/apply.sh bastion-001.aws -l root -o 'HostName=203.0.113.1' -o 'IdentitiesOnly=yes' -i ~/.ssh/id_rsa.xxx -p 22
```

Assuming NOPASSWD and having proper ssh_config.

### DNS

```
./bin/apply-route53.sh
```

### SG

```
./bin/apply-sg.sh
```
