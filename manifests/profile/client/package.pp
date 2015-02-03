class quobyte::profile::client::package {

  package { 'quobyte-client':
    ensure => latest,
  }

}
