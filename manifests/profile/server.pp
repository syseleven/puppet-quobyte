class quobyte::profile::server (
  $api_service = undef,
  $run_registry = false,
  $run_metadata = false,
  $run_data = false,
  $run_api = false,
  $run_webconsole = false,
) {

  require quobyte::profile::common::repo
  require quobyte::profile::common::java8

  class { 'quobyte::profile::server::package': }->
  class { 'quobyte::profile::server::config': }

  class { 'quobyte::profile::server::registry':
    run_service => $run_registry,
    require     => Class['quobyte::profile::server::package'],
  }

  class { 'quobyte::profile::server::metadata':
    run_service => $run_metadata,
    require     => Class['quobyte::profile::server::package'],
  }

  class { 'quobyte::profile::server::data':
    run_service => $run_data,
    require     => Class['quobyte::profile::server::package'],
  }

  class { 'quobyte::profile::server::api':
    run_service => $run_api,
    require     => Class['quobyte::profile::server::package'],
  }

  class { 'quobyte::profile::server::webconsole':
    run_service => $run_webconsole,
    require     => Class['quobyte::profile::server::package'],
  }

}
