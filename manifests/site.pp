# == Define omd::site
#
# Installes a omd site.
#
# === Parameters
#
#
# === Variables
#
#
# === Examples
#
# include 'omd::install::omd'
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
define omd::site(
  $ensure = 'present',
) {

  case $ensure {
    'installed','present': {
      exec { "omd create ${name}":
        unless  => "test -d /opt/omd/sites/${name}",
        path    => [
          '/usr/bin/',
          '/bin',
          '/usr/sbin',
          '/sbin',
        ],
      }
      omd::site::service { $name:
        ensure => $ensure,
      }
    }
    'absent','purged': {
      notify { "omd rm ${name}, not supported, yet!": }
    }
    default: {}
  }
}
