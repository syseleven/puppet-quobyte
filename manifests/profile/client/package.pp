class quobyte::profile::client::package {

  require quobyte::profile::common::repo

  package { 'quobyte-client':
    ensure => latest,
  }

}
