# Module: keepalived
# Define: keepalived::vrrp_instance
# Control keepalived VRRP instances (failover IP addresses and routes) between servers.
define keepalived::vrrp_instance($ensure=present,
                                 $interface=undef,
                                 $virtual_ipaddress,
                                 $virtual_routes=undef,
                                 $virtual_router_id=1,
                                 $mcast_src_ip=undef,
                                 $priority=100) {

  file {"/etc/keepalived/keepalived.d/keepalived_$name.conf":
    ensure  => $ensure,
    content => template("/root/vrrp_instance.conf.erb"),
    require => Package["keepalived"],
    notify  => Exec["/etc/init.d/keepalived reload"],
  }

}

