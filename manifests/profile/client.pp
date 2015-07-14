class quobyte::profile::client {

  require quobyte::profile::common::repo
  include quobyte::profile::client::monitoring

  class { 'quobyte::profile::client::package': }->
  class { 'quobyte::profile::client::config': }

}
