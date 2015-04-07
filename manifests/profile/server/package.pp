class quobyte::profile::server::package (
  $ensure_version = '1.0.RC1.p20.1',
) {

  require quobyte::profile::common::repo

  package { 'quobyte-server':
    ensure => $ensure_version,
  }

}
