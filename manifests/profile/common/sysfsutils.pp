class quobyte::profile::common::sysfsutils () {

  exec { 'sysfsutils-restart':
    command     => "service sysfsutils restart",
    path        => ['/sbin', '/usr/sbin'],
    refreshonly => true,
  }

}
