class quobyte::role::registry {

  class { 'quobyte::profile::client': }

  anchor { 'registry::start': }->
  class { 'quobyte::profile::server':
    notify => [
      Class['quobyte::profile::server::registry'],
      Class['quobyte::profile::server::metadata'],
      Class['quobyte::profile::server::data'],
      Class['quobyte::profile::server::api'],
      Class['quobyte::profile::server::webconsole'],
    ],
  }->
  class { 'quobyte::profile::server::registry': }->
  class { 'quobyte::profile::server::metadata': }->
  class { 'quobyte::profile::server::data': }->
  class { 'quobyte::profile::server::api':
    run_service => false,
  }->
  class { 'quobyte::profile::server::webconsole':
    run_service => false,
  }->
  class { 'quobyte::profile::disks': }->
  anchor { 'registry::end': }

}
