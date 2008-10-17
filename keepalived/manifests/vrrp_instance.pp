# Module: keepalived
# Define: keepalived::vrrp_instance
# Control keepalived VRRP instances (failover IP addresses and routes) between servers.
#
# Example code:
# (begin code)
# include keepalived
# keepalived::vrrp_instance {
#
#   "vlan101":
#     virtual_ipaddress => "192.0.2.1/32";
#
#   "vlan101-foo":
#     ensure            => absent,
#     interface         => "vlan101",
#     virtual_ipaddress => ["192.0.2.2/32",
#                           "192.0.2.3/32"];
#
#   "vlan102":
#     virtual_ipaddress => ["192.0.2.4/32"],
#     virtual_routes    => ["192.0.2.128/30",
#                           "192.0.2.132/30 via 102.0.2.130"
#                           "unreachable 192.0.2.192/26"];
#
#  }
# (end)
define keepalived::vrrp_instance($ensure=present,
                                 $interface=undef,
                                 $virtual_ipaddress,
                                 $virtual_routes=undef,
                                 $virtual_router_id=1,
                                 $mcast_src_ip=undef,
                                 $priority=100) {

  file {"/etc/keepalived/keepalived.d/keepalived_$name.conf":
    ensure  => $ensure,
    content => template("keepalived/vrrp_instance.conf.erb"),
    require => Package["keepalived"],
    notify  => Exec["/etc/init.d/keepalived reload"],
  }

}

