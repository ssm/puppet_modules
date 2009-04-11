# Example:
# (creates /etc/logrotate.d/foo.conf)
# logrotate::conf { "foo":
#         logfiles => ["/var/log/foo.log", "/var/log/foo-debug.log", "/var/log/foo/*.log"],
#         interval => "daily",
#         dateext => true,
#         rotate    => 5,
#         compress => true,
#         delaycompress => true,
#         sharedscripts => true,
#         postrotate => "/etc/init.d/foo reload";
# }
define logrotate::conf ($logfiles, $interval="daily", $dateext=true, $compress=true, $delaycompress=true, $sharedscripts=true, $rotate=7, $postrotate=false, $customlines=[]) {
  
  case $interval {
    "daily",
    "weekly",
    "monthly": {}
    default: { fail("Unknown interval: $interval")}
  }

  file {"/etc/logrotate.d/$name":
    content => template("logrotate/logrotate.erb")
  }
}

