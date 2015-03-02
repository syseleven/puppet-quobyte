class quobyte::profile::server::package (
  $ensure_version = '1.0.RC1.p17.1',
) {

  package { 'quobyte-server':
    ensure => $ensure_version,
  }

}
