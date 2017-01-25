node.reverse_merge!(
  kea: {
    interfaces: %w(*),
    relay_only: false,
  },
)

include_recipe '../../roles/base/default.rb'
include_recipe '../../cookbooks/kea/default.rb'
include_recipe '../../cookbooks/zabbix-userparameter-kea/default.rb'

conf = {
  Dhcp4: {
    "control-socket" => {
      "socket-type" => "unix",
      "socket-name" => "/run/kea/kea.sock",
    },
    "interfaces-config" => {
      interfaces: node[:kea][:interfaces],
      "dhcp-socket-type" => node[:kea][:relay_only] ? 'udp' : 'raw',
    },
    "lease-database" => {
      type: "memfile",
      persist: true,
      name: "/var/db/kea/dhcp4.leases",
    },
    "expired-leases-processing": {
      "reclaim-timer-wait-time": 10,
      "flush-reclaimed-timer-wait-time": 25,
      "hold-reclaimed-time": 1800,
      "max-reclaim-leases": 500,
      "max-reclaim-time": 250,
      "unwarned-reclaim-cycles": 2,
    },
    "valid-lifetime" => 2700,
    #"renew-timer" => 1000,
    #"rebind-timer" => 2000,
    subnet4: [
      {
        subnet: "10.200.0.0/20",
        id: 100,
        pools: [
          {
            pool: "10.200.1.0-10.200.15.250",
          },
        ],
        "option-data": [
          {
            name: "routers",
            code: 3,
            space: "dhcp4",
            "csv-format" => true,
            data: "10.200.0.1",
          },
        ],
      },
      {
        subnet: "10.200.16.0/24",
        id: 200,
        pools: [
          {
            pool: "10.200.16.200-10.200.16.250",
          },
        ],
        "option-data": [
          {
            name: "routers",
            code: 3,
            space: "dhcp4",
            "csv-format" => true,
            data: "10.200.16.1",
          },
        ],
      },
    ],
    "option-data": [

      {
        name: "domain-name-servers",
        code: 6,
        space: "dhcp4",
        "csv-format" => true,
        data: "10.200.17.10, 10.200.165.220, 10.200.131.194", # dns.srv, dns-001.aws, dns-002.aws
      },
    ],
  },

  Logging: {
    loggers: [
      {
        name: "kea-dhcp4",
        output_options: [
          {
            output: "/var/log/kea/kea.log",
            maxsize: 1000000,
          },
        ],
        severity: "INFO",
      },
    ],
  },
}

file "/etc/kea/kea.conf" do
  content "#{conf.to_json}\n"
  owner 'root'
  group 'root'
  mode  '0644'
end

service "kea-dhcp4" do
  action [:enable, :start]
end

