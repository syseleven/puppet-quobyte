class quobyte::profile::server::package (
  $ensure_version = '1.0.RC1.p15.1',
) {

  package { 'quobyte-usp-server':
    ensure => $ensure_version,
  }

}
