class quobyte::profile::common::sysfsutils () {

  ensure_packages(['sysfsutils'])

  exec { 'sysfsutils-restart':
    command     => "service sysfsutils restart",
    path        => ['/sbin', '/usr/sbin'],
    refreshonly => true,
  }

}
