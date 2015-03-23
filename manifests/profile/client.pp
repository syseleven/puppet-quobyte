class quobyte::profile::client {

  require quobyte::profile::common::repo

  class { 'quobyte::profile::client::package': }->
  class { 'quobyte::profile::client::config': }

}
