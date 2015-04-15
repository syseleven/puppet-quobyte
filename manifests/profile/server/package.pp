class quobyte::profile::server::package (
  $ensure_version = 'installed',
) {

  require quobyte::profile::common::repo

  package { 'quobyte-server':
    ensure => $ensure_version,
  }

}
