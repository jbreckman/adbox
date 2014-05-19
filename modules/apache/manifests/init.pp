class apache {

  # install apache
  package { "apache2":
    ensure => present,
    require => [Exec['apt-get update'], Package['php5'], Package['php5-dev'], Package['php5-cli']]
  }

  package { "libapache2-mod-proxy-html":
    ensure => present,
    require => Package["apache2"]
  }

  # ensures that mode_rewrite is loaded and modifies the default configuration file
  file { "/etc/apache2/mods-enabled/rewrite.load":
    ensure => link,
    target => "/etc/apache2/mods-available/rewrite.load",
    require => Package["apache2"]
  }

  # ensure that mod_proxy is loaded and modifies the default configuration file
  file { "/etc/apache2/mods-enabled/proxy.load":
    ensure => link,
    target => "/etc/apache2/mods-available/proxy.load",
    require => Package["apache2"]
  }

  # ensure that mod_proxy is loaded and modifies the default configuration file
#  file { "/etc/apache2/mods-enabled/proxy.conf":
#    ensure => link,
#    target => "/etc/apache2/mods-available/proxy.conf",
#    require => Package["apache2"]
#  }

  # ensure that mod_proxy is loaded and modifies the default configuration file
  file { "/etc/apache2/mods-enabled/proxy_http.load":
    ensure => link,
    target => "/etc/apache2/mods-available/proxy_http.load",
    require => Package["apache2"]
  }

  # create directory
  file {"/etc/apache2/sites-enabled":
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
    before => File["/etc/apache2/sites-enabled/vhosts"],
    require => Package["apache2"],
  }

  # create apache config from main vagrant manifests
  file { "/etc/apache2/sites-available/vhosts":
    ensure => present,
    source => "/vagrant/manifests/vhosts",
    require => Package["apache2"],
  }

  # symlink apache site to the site-enabled directory
  file { "/etc/apache2/sites-enabled/vhosts":
    ensure => link,
    target => "/etc/apache2/sites-available/vhosts",
    require => [File["/etc/apache2/sites-available/vhosts"],
      File["/etc/apache2/mods-enabled/proxy.load"],
      #File["/etc/apache2/mods-enabled/proxy.conf"],
      File["/etc/apache2/mods-enabled/proxy_http.load"]],
    notify => Service["apache2"],
  }

  # starts the apache2 service once the packages installed, and monitors changes to its configuration files and reloads if nesessary
  service { "apache2":
    ensure => running,
    require => Package["apache2"],
    subscribe => [
      File["/etc/apache2/mods-enabled/rewrite.load"],
      File["/etc/apache2/sites-available/vhosts"],
      File["/etc/apache2/mods-enabled/proxy.load"],
      #File["/etc/apache2/mods-enabled/proxy.conf"],
      File["/etc/apache2/mods-enabled/proxy_http.load"]
    ],
  }
}
