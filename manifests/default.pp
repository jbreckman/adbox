# Enable XDebug ("0" | "1")
$use_xdebug = "1"

# default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

# create a simple hostname and ip host entry
host { 'tinbox.nanigans.com':
  ip => '192.168.56.102',
  host_aliases => 'tinbox',
}

include bootstrap
include tools
include apache
include php
include php::pear
include php::pecl
include mysql
include memcached

