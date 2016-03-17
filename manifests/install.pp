# == Class: omd::install
#
# This class and its subclasses installes omd
# and all needed dependencies.
# Supported version:
# Ubuntu: 14.04
# Tested versions are listed below,
# Debian:
# * wheezy
# * jessie
#
# === Parameters
#
#
# === Variables
#
#
# === Examples
#
# include 'omd::install'
#
# === Authors
#
# Volker Schmitz <v.schmitz@tarent.de>
#
# === Copyright
#
# Copyright 2016 Volker Schmitz, unless otherwise noted
#
# === Todos:
#
class omd::install {

  include 'omd::repository'

  package { 'omd':
    ensure => installed,
  }

  Class['omd::repository'] -> Package['omd']
}
