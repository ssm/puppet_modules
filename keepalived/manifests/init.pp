# Module: keepalived
# Class: keepalived
# Install keepalived, handle service and global configuration
#
# Note: You need keepalived >= 1.1.14.  Older versions do not support the
# "include" statement.
#
class keepalived {
  package {"keepalived":
    ensure => installed,
  }

  service {"keepalived":
    ensure  => running,
    enable  => true,
    require => Package["keepalived"],
  }

  exec {"/etc/init.d/keepalived reload":
    refreshonly => true,
  }

  file {
    "/etc/keepalived/keepalived.d":
      ensure => directory;
    "/etc/keepalived/keepalived.conf":
      content => template("keepalived/keepalived.conf.erb"),
      require => Package["keepalived"],
      notify  => Service["keepalived"],
  }
}

