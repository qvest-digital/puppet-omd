# == Class: omd
#
# This module installes omd.
# Supported versions:
# Ubuntu
# * 14.04
#
# === Parameters
#
#
# === Variables
#
#
# === Examples
#
# class { 'omd': }
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
class omd {

  include 'omd::install'
  #include 'omd::config'
  include 'omd::service'

  #Class['omd::install'] -> Class['omd::config']
  Class['omd::install'] -> Class['omd::service']

}
