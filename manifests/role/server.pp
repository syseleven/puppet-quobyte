class quobyte::role::server {

include quobyte::profile::client
include quobyte::profile::disks
include quobyte::profile::server
#include quobyte::profile::server::bootstrap

Class['quobyte::profile::disks'] -> Class['quobyte::profile::server']

}
