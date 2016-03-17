# == Class: omd::install::repository
#
# Subclass of otrs::install to manage the debian apt repository.
# To be removed later after create abstract apt class for use inside the node
# definition.
# Supported versions:
# * wheezy
# * jessie
# Ubuntu
# * 14.04
#
# === Parameters
#
# === Variables
#
# [*operatingsystem_down*]
#   fact osfamily in downcase format.
#   Apt::Source URL is case sensetive.
#
# === Examples
#
#  include 'omd::repostitory'
#
# === Authors
#
# Volker Schmitz <v.schmitz@tarent.de>
#
# === Copyright
#
# Copyright 2016 Volker Schmitz unless otherwise noted
#
class omd::repository {

  $operatingsystem_down = downcase($::operatingsystem)

  apt::key { 'omd':
    id        => 'F2F97737B59ACCC92C23F8C7F8C1CA08A57B9ED7',
    server    => 'keys.gnupg.net',
  }

  apt::source { 'omd':
    location => "http://labs.consol.de/repo/stable/${operatingsystem_down}",
    release  => $::lsbdistcodename,
    require  => Apt::Key['omd'],
    include  => {
      'src' => false,
      'deb' => true,
    },
  }
}
