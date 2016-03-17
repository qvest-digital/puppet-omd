# == Define omd::site::main_mk
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
define omd::site::main_mk(
  $ensure = undef,
  $site   = 'prod',
  $max_check_attempts = '3',
  $retry_interval = '1',
  $aironet = false,
  $logfile = false,
  $inventorychecks = false,
  $inventorychecks_interval = '120',
) {

  if ! defined(Concat["/opt/omd/sites/${site}/etc/check_mk/main.mk"] ) {
    concat { "/opt/omd/sites/${site}/etc/check_mk/main.mk":
      ensure  => present,
      owner   => $site,
      group   => $site,
      mode    => '0644',
      require => Omd::Site[$site],
    }
  }

  concat::fragment { "${site}-main.mk-01":
    order   => '01',
    content => template('omd/check_mk/main.mk/01.erb'),
    target  => "/opt/omd/sites/${site}/etc/check_mk/main.mk"
  }

  if $aironet {
    concat::fragment { "${site}-aironet":
      order   => '03',
      content => template('omd/check_mk/main.mk/aironet.erb'),
      target  => "/opt/omd/sites/${site}/etc/check_mk/main.mk"
    }
  }

  if $inventorychecks {
    concat::fragment { "${site}-inventorychecks":
      order   => '05',
      content => template('omd/check_mk/main.mk/inventorychecks.erb'),
      target  => "/opt/omd/sites/${site}/etc/check_mk/main.mk"
    }
  }

  if $logfile {
    concat::fragment { "{$site}-logfile":
      order   => '04',
      content => template('omd/check_mk/main.mk/logfile.erb'),
      target  => "/opt/omd/sites/${site}/etc/check_mk/main.mk"
    }
  }

  if $max_check_attempts != false {
    concat::fragment { "${site}-main.mk-max_check_attempts":
      order   => '02',
      content => template('omd/check_mk/main.mk/max_check_attempts.erb'),
      target  => "/opt/omd/sites/${site}/etc/check_mk/main.mk"
    }
  }

  if $retry_interval != false {
    concat::fragment { "${site}-main.mk-retry_interval":
      order   => '02',
      content => template('omd/check_mk/main.mk/retry_interval.erb'),
      target  => "/opt/omd/sites/${site}/etc/check_mk/main.mk"
    }
  }
}
