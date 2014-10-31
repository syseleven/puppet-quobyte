class quobyte::role::directory {

  class { 'quobyte::profile::client': }

  anchor { 'directory::start': }->
  class { 'quobyte::profile::server':
    notify => [
      Class['quobyte::profile::server::mrc'],
      Class['quobyte::profile::server::osd'],
      Class['quobyte::profile::server::directory'],
      Class['quobyte::profile::server::apiserver'],
      Class['quobyte::profile::server::webconsole'],
    ],
  }->
  class { 'quobyte::profile::server::mrc': }->
  class { 'quobyte::profile::server::osd': }->
  class { 'quobyte::profile::server::directory': }->
  class { 'quobyte::profile::server::apiserver':
    run_service => false,
  }->
  class { 'quobyte::profile::server::webconsole':
    run_service => false,
  }->
  class { 'quobyte::profile::disks': }->
  anchor { 'directory::end': }

}
