class quobyte::profile::client {

  require quobyte::profile::common::repo

  anchor { 'client::start': }->
  class { 'quobyte::profile::client::package': }->
  class { 'quobyte::profile::client::config': }->
  anchor { 'client::end': }

}
