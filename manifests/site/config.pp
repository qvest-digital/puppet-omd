# == Define omd::site::config
#
# Configs a specific site.
#
# === Parameters
#
#
# === Variables
#
#
# === Examples
#
# omd::site::config { 'APACHE_MODE'
#   ensure => 'own'
#   site   => 'prod',
#
#
# === Authors
#
# Volker Schmitz <v.schmitz@tarent.de>
#
# === Copyright
#
# Copyright 2016 Volker Schmitz unless otherwise noted
#
# === Todos:
#
define omd::site::config(
  $ensure = undef,
  $site   = undef,
) {

  exec { "stop ${site} to config ${name}":
    command => "omd stop ${site}",
    unless  => "omd config ${site} show ${name} | grep -c ${ensure}",
    notify  => Exec["omd config ${site} set ${name} ${ensure}"],
    path    => [
      '/usr/bin/',
      '/bin',
      '/usr/sbin',
      '/sbin',
    ],
    require => Omd::Site[$site],
  }

  exec { "omd config ${site} set ${name} ${ensure}":
    refreshonly => true,
    notify      => Exec["start ${site} activating config ${name}: ${ensure}"],
    path        => [
      '/usr/bin/',
      '/bin',
      '/usr/sbin',
      '/sbin',
    ],
    require     => Omd::Site[$site],
  }

  exec { "start ${site} activating config ${name}: ${ensure}":
    command     => "omd stop ${site}",
    refreshonly => true,
    path        => [
      '/usr/bin/',
      '/bin',
      '/usr/sbin',
      '/sbin',
    ],
    require     => Omd::Site[$site],
  }
}
