# Module: keepalived
# Class: keepalived
# Control keepalived VRRP instances (failover IP addresses and routes) between servers.
# 
# Example code:
# (begin code)
# include keepalived
# keepalived::vrrp_instance { 
# 
#   "eth0":
#     virtual_ipaddress => "192.0.2.1/32";
# 
#   "eth0-foo":
#     ensure            => absent,
#     interface         => "eth0",
#     virtual_ipaddress => ["192.0.2.2/32",
#                           "192.0.2.3/32"];
# 
#   "eth0-bar":
#     interface         => "eth0",
#     virtual_ipaddress => ["192.0.2.4/32"],
#     virtual_routes    => ["192.0.2.128/30",
#                           "192.0.2.132/30 via 102.0.2.130"
#                           "unreachable 192.0.2.192/26"];
# 
#  }
# (end)
class keepalived {
  package {"keepalived":
    ensure => installed,
  }

  service {"keepalived":
    ensure => running,
    enable => true,
  }

  exec {"/etc/init.d/keepalived reload":
    refreshonly => true,
  }

  file {
    "/etc/keepalived/keepalived.d":
      ensure => directory;
    "/etc/keepalived/keepalived.conf": 
      content => template("/root/keepalived.conf.erb"),
      require => Package["keepalived"],
      notify  => Service["keepalived"],
  }
}

