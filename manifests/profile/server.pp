class quobyte::profile::server {

  require quobyte::profile::common::repo
  require quobyte::profile::common::java8

  anchor { 'server::start': }->
  class { 'quobyte::profile::server::package': }->
  class { 'quobyte::profile::server::config': }->
  anchor { 'server::end': }

}
