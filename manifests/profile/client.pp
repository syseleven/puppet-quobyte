class quobyte::profile::client(
  $monitoring = false,
) {

  require quobyte::profile::common::repo

  if $monitoring {
    include quobyte::profile::client::monitoring
  }

  class { 'quobyte::profile::client::package': }->
  class { 'quobyte::profile::client::config': }

}
