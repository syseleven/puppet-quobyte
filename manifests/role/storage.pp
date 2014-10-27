class quobyte::role::storage {

  class { 'quobyte::profile::client': }

  anchor { 'storage::start': }->
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
  class { 'quobyte::profile::server::directory':
    run_service => false,
  }->
  class { 'quobyte::profile::server::apiserver':
    run_service => false,
  }->
  class { 'quobyte::profile::server::webconsole':
    run_service => false,
  }->
  class { 'quobyte::profile::disks': }->
  anchor { 'storage::end': }

}
