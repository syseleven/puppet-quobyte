class quobyte::role::manager {

  class { 'quobyte::profile::client': }

  anchor { 'storage::start': }->
  class { 'quobyte::profile::server':
    notify => [
      Class['quobyte::profile::server::registry'],
      Class['quobyte::profile::server::metadata'],
      Class['quobyte::profile::server::data'],
      Class['quobyte::profile::server::api'],
      Class['quobyte::profile::server::webconsole'],
    ],
  }->
  class { 'quobyte::profile::disks': }->
  class { 'quobyte::profile::server::registry': }->
  class { 'quobyte::profile::server::metadata': }->
  class { 'quobyte::profile::server::data': }->
  class { 'quobyte::profile::server::api': }->
  class { 'quobyte::profile::server::webconsole': }->
  anchor { 'storage::end': }

}
