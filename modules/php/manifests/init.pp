class php {

  # package install list
  $packages = [
    "php5",
    "php5-cli",
    "php5-mysql",
    "php-pear",
    "php5-dev",
    "php5-gd",
    "php5-mcrypt",
    "php5-curl",
    "libapache2-mod-php5",
    "php5-xdebug",
    "php5-memcache",
    "php5-memcached"
  ]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

  file
  {
    "/etc/php5/apache2/php.ini":
    ensure  => present,
    owner   => root, group => root,
    notify  => Service['apache2'],
    #source => "/vagrant/puppet/templates/php.ini",
    content => template('php/php.ini.erb'),
    require => [Package['php5'], Package['apache2']],
  }

  file
  {
    "/etc/php5/cli/php.ini":
    ensure  => present,
    owner   => root, group => root,
    notify  => Service['apache2'],
    content => template('php/cli.php.ini.erb'),
    require => [Package['php5'], Package['php5-cli']],
  }

}
