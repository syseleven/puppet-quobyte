class quobyte::role::storage {

  class { 'quobyte::profile::client': }

  anchor { 'storage::start': }->
  class { 'quobyte::profile::server':
    notify => [
      Class['quobyte::profile::server::registry'],
      Class['quobyte::profile::server::metadata'],
      Class['quobyte::profile::server::data'],
      Class['quobyte::profile::server::apiserver'],
      Class['quobyte::profile::server::webconsole'],
    ],
  }->
  class { 'quobyte::profile::server::registry':
    run_service => false,
  }->
  class { 'quobyte::profile::server::metadata': }->
  class { 'quobyte::profile::server::data': }->
  class { 'quobyte::profile::server::apiserver':
    run_service => false,
  }->
  class { 'quobyte::profile::server::webconsole':
    run_service => false,
  }->
  class { 'quobyte::profile::disks': }->
  anchor { 'storage::end': }

}
