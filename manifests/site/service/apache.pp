# == Define omd::site::service::apache
#
# Manages the apache service of a site!
#
# === Parameters
#
#
# === Variables
#
#
# === Examples
#
# omd::site::apache { 'prod':
#   ensure => running,
# }
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
define omd::site::service::apache(
  $ensure = 'running',
  $site = $name
) {

  case $ensure {
    'installed','present','running', 'enable': {
      exec { "omd start ${site} apache":
        onlyif  => 'omd status prod | grep -e "apache:" | grep stopped -c',
        path    => [
          '/usr/bin/',
          '/bin',
          '/usr/sbin',
          '/sbin',
        ],
      }

      exec { "omd restart ${site} apache":
        refreshonly => true,
        path        => [
          '/usr/bin/',
          '/bin',
          '/usr/sbin',
          '/sbin',
        ],
      }
    }
    'stopped', 'disable', 'purged', 'removed': {
      exec { "omd stop ${site} apache":
        onlyif => 'omd status prod | grep -e "apache:" | grep running -c',
        path   => [
          '/usr/bin/',
          '/bin',
          '/usr/sbin',
          '/sbin',
        ],
      }
    }
    default: {}
  }
}
