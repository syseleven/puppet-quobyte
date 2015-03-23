class quobyte::profile::server (
  $api_service = undef,
) {

  require quobyte::profile::common::repo
  require quobyte::profile::common::java8

  class { 'quobyte::profile::server::package': }->
  class { 'quobyte::profile::server::config': }

}
