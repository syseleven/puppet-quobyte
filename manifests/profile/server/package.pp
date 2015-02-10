class quobyte::profile::server::package (
  $ensure_version = '1.0.RC1.p16.1',
) {

  package { 'quobyte-server':
    ensure => $ensure_version,
  }

}
