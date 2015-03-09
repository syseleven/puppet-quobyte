class quobyte::profile::server::package (
  $ensure_version = '1.0.RC1.p18',
) {

  package { 'quobyte-server':
    ensure => $ensure_version,
  }

}
