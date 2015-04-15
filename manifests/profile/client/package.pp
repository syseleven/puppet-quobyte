class quobyte::profile::client::package (
  $ensure_version = 'installed',
) {

  require quobyte::profile::common::repo

  package { 'quobyte-client':
    ensure => $ensure_version,
  }

}
