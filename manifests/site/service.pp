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
define omd::site::service(
  $ensure = 'running',
  $site = $name
) {

  case $ensure {
    'installed','present','running', 'enable': {
      exec { "omd enable ${site}":
        onlyif  => 'omd status prod | grep -e "Overall state" | grep stopped -c',
        path    => [
          '/usr/bin/',
          '/bin',
          '/usr/sbin',
          '/sbin',
        ],
      }

    }
    'stopped', 'disable', 'purged', 'removed': {
      exec { "omd disable ${site}":
        onlyif  => 'omd status prod | grep -e "Overall state" | grep running -c',
        path    => [
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
