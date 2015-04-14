class quobyte::role::server {

include quobyte::profile::client
include quobyte::profile::disks
include quobyte::profile::server

Class['quobyte::profile::disks'] -> Class['quobyte::profile::server']

}
