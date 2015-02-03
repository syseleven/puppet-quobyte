class quobyte::profile::server::package (
  $ensure_version = '1.0.RC1.p16',
) {

  package { 'quobyte-usp-server':
    ensure => $ensure_version,
  }

}
